import csv

from selenium import webdriver
from time import sleep
from random import randrange, shuffle, choice

from collections import defaultdict

def main():
    print("\nOpening Firefox...")
    opts = webdriver.FirefoxProfile(f'/home/user/.mozilla/firefox/1.default-release')
    driver = webdriver.Firefox(firefox_profile=opts)
    driver.set_page_load_timeout(40)
    # driver.maximize_window()

    columns = defaultdict(list) # each value in each column is appended to a list

    with open('top500Domains.csv') as f:
        reader = csv.DictReader(f) # read rows into a dictionary format
        for row in reader: # read a row as {column1: value1, column2: value2,...}
            for (k,v) in row.items(): # go over each column name and value 
                columns[k].append(v) # append the value into the appropriate list
                                    # based on column name k

    websites = columns["Root Domain"]
    #[
    #    
    #    "https://www.reddit.com/r/sysadmin/comments/q181fv/looks_like_facebook_is_down/",
    #    "https://bleepingcomputer.com/",
    #    "https://www.facebook.com/glua.ua",
    #"https://www.youtube.com/watch?v=NfJf_-7O00w",
    #    "https://twitter.com/Jack/status/20",
    #    "https://www.ua.pt/pt/uc/14004",
    #    "https://github.com/cloudflare/cloudflared",
    # "https://www.worldometers.info/coronavirus/country/portugal/"
    # ]

    shuffle(websites)

    for _ in range(randrange(3,12)):
        ri = randrange(0, 500)
        print("Opening " + str(websites[ri]))
        driver.get("https://" + websites[ri])
        sleep(randrange(2,12))
        for j in range(randrange(2, 4)):
            links = driver.find_elements_by_tag_name("a")
            if len(links) > 0:
                link = links[randrange(len(links))]
                print("Clicking " + str(link))
                try:
                    link.click()
                    sleep(randrange(3,8))
                except:
                    pass


if __name__ == "__main__":
	main()
