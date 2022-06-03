#!/usr/bin/env python3.9

import sys
import os
import random
import urllib.request
import argparse

import requests
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.chrome.options import Options




def main():
    parser = argparse.ArgumentParser(description='Download a random image from Google Images')
    parser.add_argument('-k', '--keywords', help='keywords to search for', required=True)
    parser.add_argument('-d', '--directory', help='directory to download the image to', required=True)
    parser.add_argument('-n', '--name', help='name of the image', required=True)
    args = parser.parse_args()

    # get the keywords from the user
    keywords = args.keywords
    directory = args.directory
    name = args.name

    # create the directory if it doesn't exist
    if not os.path.exists(directory):
        os.makedirs(directory)

    # get the image url
    url = get_image_url(keywords)

    # download the image
    download_image(url, directory, name)

def get_image_url(keywords):
    # get the url of the image
    url = 'https://www.google.com/search?q=' + keywords + '&source=lnms&tbm=isch'
    header = {'User-Agent': 'Mozilla/5.0'}
    request = urllib.request.Request(url, headers=header)
    response = urllib.request.urlopen(request)
    html = response.read()
    soup = BeautifulSoup(html, 'html.parser')
    images = soup.find_all('img')
    image_url = images[random.randint(0, len(images) - 1)].get('src')
    return image_url

def download_image(url, directory, name):
    # download the image
    urllib.request.urlretrieve(url, directory + '/' + name)

if __name__ == '__main__':
    main()
