import re
import xlsxwriter
import datetime
import time
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions
from selenium.webdriver.support.wait import WebDriverWait

websiteURl = 'https://www.lotnisko-chopina.pl/pl/odloty.html'


driver = webdriver.Chrome(executable_path='//Users//tomasz//Downloads//chromedriver')
driver.get(websiteURl)
driver.maximize_window()
for i in range(0,6):
        WebDriverWait(driver, 20).until(expected_conditions.visibility_of_element_located((By.XPATH, '/html/body/section/div[2]/div/div[2]/a')))
        buttonMoreItems = driver.find_element_by_xpath('/html/body/section/div[2]/div/div[2]/a')
        driver.execute_script("arguments[0].scrollIntoView(true);", buttonMoreItems)
        buttonMoreItems.click()
        time.sleep(4)
        htmlSource = BeautifulSoup(driver.page_source,'html.parser')


time.sleep(4)
readWebsite = htmlSource
website = readWebsite.find_all('table',attrs={'class':'flightboard departures'})

website
tableWithReadWebsite = []
tableWithEachValueFromTable = []
for item in website:
        strItem =str(item)
        newStr = strItem.replace("<td>",'\n')
        NewStr2= newStr.replace("</td>",'\n')


        tableWithReadWebsite =NewStr2.split('\n')

iteratorOfName = 0
iteratorOfClomun=0

rowCounter = 0
nameForFile = "scraperForFlights-"+str(datetime.date.today())+".xlsx"
newDataExcel = xlsxwriter.Workbook(nameForFile)

flightsInfoWorksheet = newDataExcel.add_worksheet("Flights Information")
def writeExcel(columnNumber,rowNumber, dataValue):
        flightsInfoWorksheet.write(rowNumber,columnNumber,dataValue)

tableWithReadWebsite= list(filter(None,tableWithReadWebsite))

for item in tableWithReadWebsite:
        if item.__contains__("</th>"):
                item = item.replace("</th>","")
                nameOfColumn = item.split(">")
                writeExcel(iteratorOfClomun,rowCounter,nameOfColumn[1])
                iteratorOfName += 1
                iteratorOfClomun+=1
                if iteratorOfClomun == 9:
                        iteratorOfClomun=0
                        rowCounter +=1
                continue
        elif item.__contains__("td"):
                helpVar = item.split(">")
                item= helpVar[len(helpVar)-1]
                item.strip()

        if item.__contains__("</") or item.__contains__(">") or len(item)==0:
                continue
        item.strip()
        test =re.match('[1-2][1-9]:[0-5][0-9]',item)
        iteratorOfName += 1


        if iteratorOfClomun == 8 and len(item) >3  and iteratorOfName>11:
                writeExcel(iteratorOfClomun, rowCounter, "-")
                iteratorOfClomun += 1
                if iteratorOfClomun > 8:
                        iteratorOfClomun = 0
                        rowCounter +=1
                        writeExcel(iteratorOfClomun, rowCounter, item)
                        iteratorOfClomun += 1
                        continue
        elif iteratorOfClomun == 5 and len(item)<=6 and iteratorOfName>11:
                writeExcel(iteratorOfClomun,rowCounter,"-")
                iteratorOfClomun+=1
                writeExcel(iteratorOfClomun, rowCounter, item)
                iteratorOfClomun += 1
                continue

        writeExcel(iteratorOfClomun, rowCounter, item)
        iteratorOfClomun += 1
        if iteratorOfClomun>8:
                iteratorOfClomun=0
                rowCounter+=1
newDataExcel.close()
driver.close()