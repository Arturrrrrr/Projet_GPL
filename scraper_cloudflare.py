import cloudscraper

def main():
    # Crée un scraper qui gère automatiquement les challenges Cloudflare
    scraper = cloudscraper.create_scraper()  # returns a requests.Session object

    url = "https://bitinfocharts.com/bitcoin/"

    # Faire la requête
    response = scraper.get(url)

    # Vérifier le code de statut
    if response.status_code == 200:
        html_content = response.text
        # Afficher ou analyser le HTML
        print("Contenu HTML récupéré :")
        print(html_content)
    else:
        print(f"Erreur: code HTTP {response.status_code}")

if __name__ == "__main__":
    main()
