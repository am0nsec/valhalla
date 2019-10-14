#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "[+] Simple iptable counter"
  echo "[+] Usage: $0 <source ip> <destination ip>"
  exit 0
fi

# Reset all counters and iptables rules
iptables -Z && iptables -F
# Measure incoming traffic to input addr
iptables -I INPUT 1 -s $1 -j ACCEPT
# Measure outgoing traffic to output addr
iptables -I OUTPUT 1 -d $2 -j ACCEPT
echo "OK"
