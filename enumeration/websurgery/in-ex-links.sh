#!/bin/bash

if [ -z "$1" ]; then
  echo "[*] Simply find all internal or external links in the given web page "
  echo "[*] Usage: $0 <URL>"
  echo ""
  exit 1
fi

curl $1  -s -L |grep "title\|href" |sed -e 's/^[[:space:]]*//'
