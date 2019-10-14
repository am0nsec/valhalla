#!/usr/bin/python3
import re
import sys
import requests
import argparse
import datetime
from bs4 import BeautifulSoup
from urllib.parse import urlparse, urljoin

"""
Author: amonsec
Website: https://amonsec.net

Just a spider
"""


class Utils(object):

    def __init__(self):
        """
        Color variables
        """
        self._RED = '\x1b[1;31m'
        self._BLU = '\x1b[1;34m'
        self._GRE = '\x1b[1;32m'
        self._YEL = '\x1b[1;33m'
        self._RST = '\x1b[0;0;0m'

    def success_message(self, message: str = None) -> str:
        """
        Return the formatted message for an success

        :param message:
        :return:
        """
        return '[{}+{}] {}'.format(self._GRE, self._RST, message)

    def error_message(self, message: str = None) -> str:
        """
        Return the formatted message for an error

        :param message:
        :return:
        """
        return '[{}+{}] {}'.format(self._RED, self._RST, message)

    def info_message(self, message: str = None) -> str:
        """
        Return the formatted message for an information

        :param message:
        :return:
        """
        return '[{}+{}] {}'.format(self._BLU, self._RST, message)


class Spider(Utils):

    def __init__(self, target: str, deep: int, verbose: bool = False) -> None:
        super(Spider, self).__init__()
        self.target = target
        self.deep = deep
        self.verbose = verbose

        self.previously_found = set()

    def start(self) -> None:
        print(self.info_message("Author: Paul Laîné"))
        print(self.info_message("Start at: {}".format(datetime.datetime.now().strftime("%Y-%m-%d %H:%M"))))
        self.crawler(self.target, "/", [])

    @staticmethod
    def sanitiser(current_target: str, href: str) -> str or None:
        if not href:
            return None

        if href.startswith("#"):
            return None

        absolute_url = urljoin(current_target, href)
        # Remove tel
        if re.findall('(.+)?tel:\d+', absolute_url):
            return None

        base_url_host = urlparse(current_target).hostname.replace('www.', '')
        absolute_url_host = urlparse(absolute_url).hostname.replace('www.', '')
        if absolute_url_host != base_url_host:
            return None

        return absolute_url

    def crawler(self, current_target: str,  url: str, history: list) -> None:
        """
        Deletes all the elements in the array
        """
        current_path = history[:]
        if len(current_path) > self.deep:
            return None

        current_path.append(url)
        print(self.info_message("Path: {}".format(current_path)))
        self.previously_found.add(current_target)

        """
        Basically making the request
        Only GET cuz yes only GET
        """
        resp = requests.get(current_target)

        # I'm mental so no status check
        soup = BeautifulSoup(resp.text, "html.parser")
        for link in soup.findAll("a"):
            new_url = self.sanitiser(current_target, link.get("href"))

            if new_url and new_url not in self.previously_found:
                self.crawler(current_target, new_url, current_path)


__banner__ = """
 _____       _     _           
/  ___|     (_)   | |          
\ `--. _ __  _  __| | ___ _ __ 
 `--. \ '_ \| |/ _` |/ _ \ '__|
/\__/ / |_) | | (_| |  __/ |   
\____/| .__/|_|\__,_|\___|_|   
      | |                      
      |_|  developed by *cough* French Intelligence *cough*
"""

"""
Entrypoint
"""
if __name__ == "__main__":
    # Street cred
    print(__banner__)

    parser = argparse.ArgumentParser(description="Recursive web spider")
    parser.add_argument("--target", help="The targeted website", required=True)
    parser.add_argument("--deep", help="The max deep", required=True)
    parser.add_argument("--verbose", help="Verbosity", action="store_true")
    args = parser.parse_args()

    try:
        utils = Utils()
        spider = Spider(args.target, int(args.deep), args.verbose)
        spider.start()
    except KeyboardInterrupt:
        print()
        sys.exit(0)

    print()
    print(utils.info_message("Stop at: {}".format(datetime.datetime.now().strftime("%Y-%m-%d %H:%M"))))
    sys.exit(0)
