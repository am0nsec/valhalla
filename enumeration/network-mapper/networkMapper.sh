#!/bin/bash

function helper() {
  echo "[INFO] You need to use 1 argument."
  echo "[INFO] Argument 1: network address."
  echo "[INFO] Argument 2: CIDR are allow 8, 16, 24."
  echo -e "[INFO] Exemple: "$0" 10.11.1.0 24\n"
}

function twentyfour() {
  touch report.txt
  echo -e "----- \x1b[35m$1\x1b[37m -----"
  for x in $(seq 1 254); do
    (ping -c 1 ${1::-2}.$x -w 5 |grep "bytes from" |cut -d" " -f4 |cut -d":" -f1 &)
  done
}

function sixteen() {
  touch report.txt
  for x in $(seq 0 254); do
    echo -e "----- \x1b[35m$1.$x.0\x1b[37m -----"
    for y in $(seq 1 254); do
      (ping -c 1 $1.$x.$y -w 5 |grep "bytes from" |cut -d" " -f4 |cut -d":" -f1 &)
    done
  done
}

function eight() {
  touch report.txt
  for x in $(seq 0 254); do
    for y in $(seq 0 254); do
      echo -e "----- \x1b[35m$1.$x.$y.0\x1b[37m -----"
      for i in $(seq 1 254); do
        (ping -c 1 $1.$x.$y.$i -w 5 |grep "bytes from" |cut -d" " -f4 |cut -d":" -f1 &)
      done
    done
  done
}

echo "[+] Start program"
if [ "$1" == "" ] || [ "$2" == "" ]; then
  helper
else
  case "$2" in
    24) twentyfour $1;;
    16) sixteen $( echo "$1" | cut -d "." -f 1,2);;
    8) eight $( echo "$1" | cut -d "." -f 1);;
    *) helper;;
  esac
fi
