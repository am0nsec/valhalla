#!/bin/bash
##
## List clone from the rbsec/dnscan git project
## https://github.com/rbsec/dnscan
##

if [ ! type curl &> /dev/null ]; then
  echo -e "[\e[31m+\e[39m] You need to install curl befor running this script!"
  echo -e "[\e[31m+\e[39m] apt-get install curl"
  echo -e "[\e[31m+\e[39m] or something like that."
  exit
fi

# Create the list with 100 entries
echo -e "[\e[34m+\e[39m] Create subdoains-100.txt ..."
if [ -f subdomains-100.txt ]; then
  echo -n "subdomains-100.txt already exist, do you want to remove it (Y/n): "
  read rep
  if [ "$rep" == "y" ] || [ "$rep" == "Y" ]; then
    rm subdomains-100.txt
  fi
fi
if (curl https://github.com/rbsec/dnscan/blob/master/subdomains-100.txt |grep 'js-file-line">' |cut -d">" -f2 |cut -d"<" -f1 >> subdomains-100.txt); then
  echo ""
  echo -e "[\e[34m+\e[39m] Create subdomains-100.txt ... \e[32mOK\e[39m"
else
  echo ""
  echo -e "[\e[34m+\e[39m] Create subdomains-100.txt ... \e[31mERROR\e[39m"
fi

# Create the list with 500 entries
echo -e "[\e[34m+\e[39m] Create subdomains-500.txt ..."
if [ -f subdomains-500.txt ]; then
  echo -n "subdomains-500.txt already exist, do you want to remove it (Y/n): "
  read srep
  if [ "$srep" == "y" ] || [ "$srep" == "Y" ]; then
    rm subdomains-500.txt
  fi
fi
if (curl https://github.com/rbsec/dnscan/blob/master/subdomains-500.txt |grep 'js-file-line">' |cut -d">" -f2 |cut -d"<" -f1 >> subdomains-500.txt); then
  echo ""
  echo -e "[\e[34m+\e[39m] Create subdomains-500.txt ... \e[32mOK\e[39m"
else
  echo ""
  echo -e "[\e[34m+\e[39m] Create subdomains-500.txt ... \e[31mERROR\e[39m"
fi

# Create the list with 1 000 entries
echo -e "[\e[34m+\e[39m] Create subdomains-1000.txt ..."
if [ -f subdomains-1000.txt ]; then
  echo -n "subdomains-1000.txt already exist, do you want to remove ot (Y/n): "
  read trep
  if [ "$trep" == "y" ] || [ "$trep" == "Y" ]; then
    rm subdomains-1000.txt
  fi
fi
if (curl https://github.com/rbsec/dnscan/blob/master/subdomains-1000.txt |grep 'js-file-line">' |cut -d">" -f2 |cut -d"<" -f1 >> subdomains-1000.txt); then
  echo ""
  echo -e "[\e[34m+\e[39m] Create subdomains-1000.txt ... \e[32mOK\e[39m"
else
  echo ""
  echo -e "[\e[34m+\e[39m] Create subdomains-1000.txt ... \e[31mERROR\e[39m"
fi

# Create the list with 10 000 entries
echo -e "[\e[34m+\e[39m] Create subdomains-10000.txt ... "
if [ -f subdomains-10000.txt ]; then
  echo -n "subdomains-10000.txt already exist, do you want to remove it (Y/n): "
  read frep
  if [ "$frep" == "y" ] || [ "$frep" == "Y" ]; then
    rm subdomains-10000.txt
  fi
fi
if (curl https://github.com/rbsec/dnscan/blob/master/subdomains-10000.txt |grep 'js-file-line">' |cut -d">" -f2 |cut -d"<" -f1 >> subdomains-10000.txt); then
  echo ""
  echo -e "[\e[34m+\e[39m] Create subdomains-10000.txt ... \e[32mOK\e[39m"
else
  echo ""
  echo -e "[\e[34m+\e[39m] Create subdomains-10000.txt ... \e[31mERROR\e[39m"
fi
