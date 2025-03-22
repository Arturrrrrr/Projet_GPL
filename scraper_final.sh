#!/bin/bash
CAC40=$(curl 'https://live.euronext.com/en/ajax/getDetailedQuote/FR0003500008-XPAR' \
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
price_cac40=$(echo "$CAC40" \
 | grep -oP '<span class="display-5" id="header-instrument-price">\K[\d,.]+' )

# Gérer le cas où aucun prix n'est trouvé
if [ -z "$price_cac40" ]; then
    price_cac40="N/A"
fi

# Formatter la date et l'heure actuelle
timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Définir le fichier CSV pour enregistrer les données
CSV_CAC40="/home/ubuntu/PGL/Projet_GPL/CAC40.csv"

# Écrire la donnée dans le fichier CSV
echo "$timestamp;$price_cac40" >> "$CSV_CAC40"

# Afficher la sortie
echo "[$timestamp] : $price_cac40"



AEX=$(curl 'https://live.euronext.com/en/ajax/getDetailedQuote/NL0000000107-XAMS' \
  -H 'accept: */*' \
  -H 'accept-language: en-GB,en;q=0.9' \
  -b 'visid_incap_2784297=F1QADSf7Qt++PGp8r83IsfOp3WcAAAAAQUIPAAAAAAB2jkEOEqf0sRgMfr/eNHMM; incap_ses_1516_2784297=oyFIGtLmpjfOeymwNuoJFfOp3WcAAAAAzxYl6CJJGQ2AGfpiH3WA/Q==; visid_incap_2691598=1e7OVabNSYqNwI2luqSpmUKr3WcAAAAAQUIPAAAAAAA7dMu3vLU/kcYcgrk2emmI; incap_ses_1516_2691598=y8OFGqwCcxf66yqwNuoJFUKr3WcAAAAAczzduym4NWruYEGxwVMcRw==; visid_incap_2790185=3a/HDe23SYOg7oWPH6vSokar3WcAAAAAQUIPAAAAAAAOb4OWX1zEz8/ugZjT7sKP; incap_ses_1516_2790185=eVphAHUaDhnh7yqwNuoJFUar3WcAAAAAHH802VKv1d1v6NsUpyUPGA==' \
  -H 'priority: u=1, i' \
  -H 'referer: https://live.euronext.com/en/product/indices/NL0000000107-XAMS' \
  -H 'sec-ch-ua: "Chromium";v="134", "Not:A-Brand";v="24", "Brave";v="134"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-gpc: 1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest')

# Extraire le prix du Bitcoin depuis le titre de la page
price_aex=$(echo "$AEX" \
 | grep -oP '<span class="data-60" id="header-instrument-price">\K[\d,.]+' )

# Gérer le cas où aucun prix n'est trouvé
if [ -z "$price_aex" ]; then
    price_aex="N/A"
fi

# Définir le fichier CSV pour enregistrer les données
CSV_AEX="/home/ubuntu/PGL/Projet_GPL/AEX.csv"

# Écrire la donnée dans le fichier CSV
echo "$timestamp;$price_aex" >> "$CSV_AEX"

# Afficher la sortie
echo "[$timestamp] : $price_aex"


BEL20=$(curl 'https://live.euronext.com/en/ajax/getDetailedQuote/BE0389555039-XBRU' \
  -H 'accept: */*' \
  -H 'accept-language: en-GB,en;q=0.9' \
  -b 'visid_incap_2784297=F1QADSf7Qt++PGp8r83IsfOp3WcAAAAAQUIPAAAAAAB2jkEOEqf0sRgMfr/eNHMM; incap_ses_1516_2784297=oyFIGtLmpjfOeymwNuoJFfOp3WcAAAAAzxYl6CJJGQ2AGfpiH3WA/Q==; visid_incap_2691598=1e7OVabNSYqNwI2luqSpmUKr3WcAAAAAQUIPAAAAAAA7dMu3vLU/kcYcgrk2emmI; incap_ses_1516_2691598=y8OFGqwCcxf66yqwNuoJFUKr3WcAAAAAczzduym4NWruYEGxwVMcRw==; visid_incap_2790185=3a/HDe23SYOg7oWPH6vSokar3WcAAAAAQUIPAAAAAAAOb4OWX1zEz8/ugZjT7sKP; incap_ses_1516_2790185=eVphAHUaDhnh7yqwNuoJFUar3WcAAAAAHH802VKv1d1v6NsUpyUPGA==' \
  -H 'priority: u=1, i' \
  -H 'referer: https://live.euronext.com/en/product/indices/BE0389555039-XBRU' \
  -H 'sec-ch-ua: "Chromium";v="134", "Not:A-Brand";v="24", "Brave";v="134"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-gpc: 1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest')

# Extraire le prix du Bitcoin depuis le titre de la page
price_bel20=$(echo "$BEL20" \
 | grep -oP '<span class="display-5" id="header-instrument-price">\K[\d,.]+' )

# Gérer le cas où aucun prix n'est trouvé
if [ -z "$price_bel20" ]; then
    price_bel20="N/A"
fi

# Définir le fichier CSV pour enregistrer les données
CSV_BEL20="/home/ubuntu/PGL/Projet_GPL/BEL20.csv"

# Écrire la donnée dans le fichier CSV
echo "$timestamp;$price_bel20" >> "$CSV_BEL20"

# Afficher la sortie
echo "[$timestamp] : $price_bel20"

PSI=$(curl 'https://live.euronext.com/en/ajax/getDetailedQuote/PTING0200002-XLIS' \
  -H 'accept: */*' \
  -H 'accept-language: en-GB,en;q=0.9' \
  -b 'visid_incap_2784297=F1QADSf7Qt++PGp8r83IsfOp3WcAAAAAQUIPAAAAAAB2jkEOEqf0sRgMfr/eNHMM; incap_ses_1516_2784297=oyFIGtLmpjfOeymwNuoJFfOp3WcAAAAAzxYl6CJJGQ2AGfpiH3WA/Q==; visid_incap_2691598=1e7OVabNSYqNwI2luqSpmUKr3WcAAAAAQUIPAAAAAAA7dMu3vLU/kcYcgrk2emmI; visid_incap_2790185=3a/HDe23SYOg7oWPH6vSokar3WcAAAAAQUIPAAAAAAAOb4OWX1zEz8/ugZjT7sKP; incap_ses_1516_2790185=eVphAHUaDhnh7yqwNuoJFUar3WcAAAAAHH802VKv1d1v6NsUpyUPGA==; incap_ses_1516_2691598=cFCPDJalrmgkEzCwNuoJFSyw3WcAAAAAxup/WQ/X48EpV4mcDzl+GA==' \
  -H 'priority: u=1, i' \
  -H 'referer: https://live.euronext.com/en/product/indices/PTING0200002-XLIS' \
  -H 'sec-ch-ua: "Chromium";v="134", "Not:A-Brand";v="24", "Brave";v="134"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-gpc: 1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest')

# Extraire le prix du Bitcoin depuis le titre de la page
price_psi=$(echo "$PSI" \
 | grep -oP '<span class="display-5" id="header-instrument-price">\K[\d,.]+' )

# Gérer le cas où aucun prix n'est trouvé
if [ -z "$price_psi" ]; then
    price_psi="N/A"
fi

# Définir le fichier CSV pour enregistrer les données
CSV_PSI="/home/ubuntu/PGL/Projet_GPL/PSI.csv"

# Écrire la donnée dans le fichier CSV
echo "$timestamp;$price_psi" >> "$CSV_PSI"

# Afficher la sortie
echo "[$timestamp] : $price_psi"


ISEQ20=$(curl 'https://live.euronext.com/en/ajax/getDetailedQuote/IE00B0500264-XDUB' \
  -H 'accept: */*' \
  -H 'accept-language: en-GB,en;q=0.9' \
  -b 'visid_incap_2784297=F1QADSf7Qt++PGp8r83IsfOp3WcAAAAAQUIPAAAAAAB2jkEOEqf0sRgMfr/eNHMM; incap_ses_1516_2784297=oyFIGtLmpjfOeymwNuoJFfOp3WcAAAAAzxYl6CJJGQ2AGfpiH3WA/Q==; visid_incap_2691598=1e7OVabNSYqNwI2luqSpmUKr3WcAAAAAQUIPAAAAAAA7dMu3vLU/kcYcgrk2emmI; visid_incap_2790185=3a/HDe23SYOg7oWPH6vSokar3WcAAAAAQUIPAAAAAAAOb4OWX1zEz8/ugZjT7sKP; incap_ses_1516_2790185=eVphAHUaDhnh7yqwNuoJFUar3WcAAAAAHH802VKv1d1v6NsUpyUPGA==; incap_ses_1516_2691598=cFCPDJalrmgkEzCwNuoJFSyw3WcAAAAAxup/WQ/X48EpV4mcDzl+GA==' \
  -H 'priority: u=1, i' \
  -H 'referer: https://live.euronext.com/en/product/indices/IE00B0500264-XDUB' \
  -H 'sec-ch-ua: "Chromium";v="134", "Not:A-Brand";v="24", "Brave";v="134"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-gpc: 1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest')

price_iseq20=$(echo "$ISEQ20" \
 | grep -oP '<span class="display-5" id="header-instrument-price">\K[\d,.]+' )

# Gérer le cas où aucun prix n'est trouvé
if [ -z "$price_iseq20" ]; then
    price_iseq20="N/A"
fi

# Définir le fichier CSV pour enregistrer les données
CSV_ISEQ20="/home/ubuntu/PGL/Projet_GPL/ISEQ20.csv"

# Écrire la donnée dans le fichier CSV
echo "$timestamp;$price_iseq20" >> "$CSV_ISEQ20"

# Afficher la sortie
echo "[$timestamp] : $price_iseq20"


OBX=$(curl 'https://live.euronext.com/en/ajax/getDetailedQuote/NO0000000021-XOSL' \
  -H 'accept: */*' \
  -H 'accept-language: en-GB,en;q=0.9' \
  -b 'visid_incap_2784297=F1QADSf7Qt++PGp8r83IsfOp3WcAAAAAQUIPAAAAAAB2jkEOEqf0sRgMfr/eNHMM; incap_ses_1516_2784297=oyFIGtLmpjfOeymwNuoJFfOp3WcAAAAAzxYl6CJJGQ2AGfpiH3WA/Q==; visid_incap_2691598=1e7OVabNSYqNwI2luqSpmUKr3WcAAAAAQUIPAAAAAAA7dMu3vLU/kcYcgrk2emmI; visid_incap_2790185=3a/HDe23SYOg7oWPH6vSokar3WcAAAAAQUIPAAAAAAAOb4OWX1zEz8/ugZjT7sKP; incap_ses_1516_2790185=eVphAHUaDhnh7yqwNuoJFUar3WcAAAAAHH802VKv1d1v6NsUpyUPGA==; incap_ses_1516_2691598=cFCPDJalrmgkEzCwNuoJFSyw3WcAAAAAxup/WQ/X48EpV4mcDzl+GA==' \
  -H 'priority: u=1, i' \
  -H 'referer: https://live.euronext.com/en/product/indices/NO0000000021-XOSL' \
  -H 'sec-ch-ua: "Chromium";v="134", "Not:A-Brand";v="24", "Brave";v="134"' \
  -H 'sec-ch-ua-mobile: ?0' \
  -H 'sec-ch-ua-platform: "Windows"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: same-origin' \
  -H 'sec-gpc: 1' \
  -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36' \
  -H 'x-requested-with: XMLHttpRequest')

price_obx=$(echo "$OBX" \
 | grep -oP '<span class="display-6" id="header-instrument-price">\K[\d,.]+' )

# Gérer le cas où aucun prix n'est trouvé
if [ -z "$price_obx" ]; then
    price_obx="N/A"
fi

# Définir le fichier CSV pour enregistrer les données
CSV_OBX="/home/ubuntu/PGL/Projet_GPL/OBX.csv"

# Écrire la donnée dans le fichier CSV
echo "$timestamp;$price_obx" >> "$CSV_OBX"

# Afficher la sortie
echo "[$timestamp] : $price_obx"


