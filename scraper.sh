#!/bin/bash
# scraper qui recuere le prix du Bitcoin sur la page KuCoin "Bitcoin Price (BTC)"
# et l'enregistre dans un CSV.

# URL de KuCoin
URL="https://www.kucoin.com/fr/price/BTC"

# recupere le contenu HTML de la page en imitant un navigateur
html_content=$(curl -s -A "Mozilla/5.0" "$URL")

# On extrait ensuite la valeur monétaire dans <h2 class="lrtcss-sde0qk">...</h2>
price=$(echo "$html_content" \
  | grep -oP '(?<=<h2 class="lrtcss-sde0qk">)\$?[0-9,]+(\.[0-9]+)?(?=</h2>)' \
  | head -n 1)

# Dans le cas d'un erreur si la regex ne trouve rien, on met "N/A"
if [ -z "$price" ]; then
    price="N/A"
fi

# Récupération de l'heure
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Fichier CSV de sortie
CSV_FILE="data_kucoin.csv"

# on rédige la ligne (timestamp, prix) dans le CSV
echo "$timestamp,$price" >> "$CSV_FILE"

# Afficher le résultat pour vérification
echo "[$timestamp] Prix du Bitcoin (KuCoin) : $price"

