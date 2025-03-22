#!/bin/bash
=$html_content(curl 'https://live.euronext.com/en/ajax/getDetailedQuote/FR0003500008-XPAR' \
  -H 'accept: */*' \
  -H 'accept-language: en-US,en;q=0.6' \
  -b 'visid_incap_2790185=XImDpAicSim3shRTA5d1jit7F2cAAAAAQUIPAAAAAAA4IUgxjbj8LfUu/XYFdTWF; visid_incap_2784265=rYFr5fh8Qw6Dn3OEqzZHCz57F2cAAAAAQUIPAAAAAAAbZ5IKpjTM9h6jXmzSKPNE; visid_incap_2784297=pCDW0gMNSlmvuAx6GA97ux+B1WcAAAAAQUIPAAAAAABEFAQkMx3haqpCBqB/MtJN; visid_incap_2691598=RnU32VkcQHOD1Z9pGCK1ZiCB1WcAAAAAQUIPAAAAAABHhBZlcORyUkT4Vu9BC6GL; incap_ses_465_2784297=YlqcYdvUUjAu0vjYTAN0BhTy1mcAAAAAb+H/p1NwlioNKjc75fZJ2w==; incap_ses_465_2790185=r/CbVXxRuR/J1PjYTAN0Bhny1mcAAAAAyAY9/0OFz4lGnHCiK2oHkg==; incap_ses_465_2691598=XqRzcjXcI1bA1PjYTAN0Bhry1mcAAAAACSKbV/YaNlK+jPxQIgTIFw==' \
  -H 'priority: u=1, i' \
  -H 'referer: https://live.euronext.com/en/product/indices/FR0003500008-XPAR' \
  -H 'sec-ch-ua: "Chromium";v="134", "Not:A-Brand";v="24", "Brave";v="134"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-gpc: 1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest')

# URL de la page CoinCodex pour Bitcoin
#URL="https://live.euronext.com/en/product/indices/FR0003500008-XPAR"

# Récupérer le contenu HTML de la page (avec User-Agent pour éviter les blocages)
#html_content=$(curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" "$URL")

# Extraire le prix du Bitcoin depuis le titre de la page
price=$(echo "$html_content" \
 | grep -oP '<span class="display-5" id="header-instrument-price">\K[\d,.]+' )

# Gérer le cas où aucun prix n'est trouvé
if [ -z "$price" ]; then
    price="N/A"
fi

# Formatter la date et l'heure actuelle
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Définir le fichier CSV pour enregistrer les données
CSV_FILE="/home/ubuntu/PGL/Projet_GPL/data_euronext.csv"

# Écrire la donnée dans le fichier CSV
echo "$timestamp;$price" >> "$CSV_FILE"

# Afficher la sortie
echo "[$timestamp] : $price"


