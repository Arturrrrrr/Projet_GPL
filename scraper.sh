#!/bin/bash
# scraper_bitinfocharts.sh - Récupère le prix du Bitcoin depuis BitInfoCharts et l'enregistre dans un CSV

URL="https://bitinfocharts.com/bitcoin/"

# Récupérer le contenu HTML de la page (user-agent complet pour imiter un navigateur)
html_content=$(curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.0.0 Safari/537.36" "$URL")

# Utiliser \K au lieu d'un lookbehind variable
# On recherche d'abord 'span itemprop="price"[^>]*>' puis on jette cette partie, 
# et on capture la suite [0-9,]+(\.[0-9]+)? jusqu'au lookahead (?=</span>)
price=$(echo "$html_content" \
  | grep -oP 'span itemprop="price"[^>]*>\K[0-9,]+(\.[0-9]+)?(?=</span>)' \
  | head -n 1)

# Gérer le cas où aucun prix n'est trouvé
if [ -z "$price" ]; then
    price="N/A"
fi

timestamp=$(date "+%Y-%m-%d %H:%M:%S")

CSV_FILE="/home/adot/Documents/data_bitinfocharts.csv"
echo "$timestamp;$price" >> "$CSV_FILE"

echo "[$timestamp] Prix BTC (BitInfoCharts) : $price"
