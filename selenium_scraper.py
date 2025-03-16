from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import time

def main():
    # Configurer les options de Chrome
    chrome_options = Options()
    chrome_options.add_argument("--headless")          # mode headless (pas d'interface)
    chrome_options.add_argument("--no-sandbox")        # requis sur certaines VM
    chrome_options.add_argument("--disable-dev-shm-usage")
    chrome_options.add_argument("--disable-blink-features=AutomationControlled")
    chrome_options.add_experimental_option("excludeSwitches", ["enable-automation"])
    chrome_options.add_experimental_option('useAutomationExtension', False)

    # Créer l'instance du driver
    # Sur Ubuntu, si 'chromedriver' est dans PATH, ça devrait marcher directement :
    driver = webdriver.Chrome(options=chrome_options)

    try:
        url = "https://bitinfocharts.com/bitcoin/"
        driver.get(url)

        # Attendre un peu (optionnel), pour s'assurer que le JavaScript se charge
        time.sleep(15)

        # Récupérer le HTML final
        html_content = driver.page_source

        # Afficher ou enregistrer dans un fichier
        print("Taille du HTML:", len(html_content))
        with open("page_selenium.html", "w", encoding="utf-8") as f:
            f.write(html_content)

    finally:
        # Fermer le navigateur
        driver.quit()

if __name__ == "__main__":
    main()
