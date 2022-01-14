import urllib.request
from bs4 import BeautifulSoup
# script to scrap a meteo web site to collect local temperature
urlpage = 'https://www.meteo-concept.fr/observations/station/GRENOBLE%20-%20LVD'
page = urllib.request.urlopen(urlpage)

# parse the page 
soup = BeautifulSoup(page, 'html.parser')

# find the right div element
results = soup.find_all('div', attrs={'class': 'bloc', 'id':'last-temperature'})

# get the right span 
r2=results[0].find_all('span',attrs={'class': 'value'})

#and print its value
print(r2[0].get_text())
