READ ME

To do this project we scraped Euronext's website (https://live.euronext.com/en)

The objective we set for ourselves was to compare european indices by scraping only the level of one main index per country (available on Euronext)

Thus, we selected the following indices:

    - CAC40 : France
    - AEX : Amsterdam
    - BEL20 : Belgium
    - PSI20 : Lisbonne
    - ISEQ20 : Dublin
    - OBX : Oslo

With the prices of each index we first plotted the related levels to compare the movements, and added a daily recap providing metrics like the highs, lows, volatilities, open and close prices.

To proceed, we: 
- tried extracting data on different websites localy with curl and grep
- started with something simple like the CAC40 indice level
- sometimes the scraping is difficult when running from the aws server, so we switched websites
- automated the scraper with cron to run every 5min and store the data into a csv file
- did this for other indices to be able to compare
- built the dash interface with python containing a comparative graph and a daily report
- automated the daily reports and update of the dashbaord to make it an accessible adress through the 8050 port with gunicorn and nginx
- fixed issues with the graph

    - curves were not continuous because of times when the market is closed so we first tried using datetime functions to slice the time index then decided to create another one adding every data point one after the other
    - fixed the daily report's refreshing time and some metrics
    - scales and adjusted % change
    - bugs when nothing would show on the dashbaord because of git conflicts or server issues


