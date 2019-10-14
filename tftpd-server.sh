#!/bin/bash

function start_daemon() {
  echo "[*] Create temporary folder" 
  mkdir /tftp
  echo "[*] /tftpd"
  echo "[*] Start atftpd daemon on port 69"
  atftpd --daemon --port 69 /tftpd
}

function stop_daemon() {
  echo "[*] Get the proccess id"
  pid=$(lsof -i :69 -t)
  echo "[*] Kill the pid $pid"
  kill -9 $pid
  echo "[*] Remove temporary /tftp folder"
  rm -rf /tftp
}

function helper() {
  echo "[*] Simple TFTPD server"
  echo "[*] Require atftpd"
  echo "[*] Usage: $0 <option>"
  echo "[*] OPTIONS:"
  echo -e "[*]\t --start : start the server"
  echo -e "[*]\t --stop : stop the server"
  echo ""
  exit 0
}

echo "[*] Start the scrip"
if [ -z $1 ]; then
  helper
fi

case $1 in 
  --start) start_daemon;;
  --stop) stop_daemon;;
  *) helper;;
esac
