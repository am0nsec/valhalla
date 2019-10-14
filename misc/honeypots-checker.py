#!/usr/bin/python3
import requests
import sys

if len(sys.argv) < 2:
    print("[*] HONEYPOTS CHECKER")
    print("[*] Usage : " + (sys.argv[0]).split(".")[1] + " <ip addr>")
    sys.exit()

print("[*] HONEYPOTS CHECKER")
print("[*] Get wordlist from http://pastebin.com/raw/dgt5fk69")
resp = requests.get("http://pastebin.com/raw/dgt5fk69")
if resp.status_code != 200:
    print("Oooops something goes wrong!")
    sys.exit(1)

ips = resp.text.split()
for x in ips:
    if sys.argv[1] == x:
        print("[+] Its an honeypot dude")
        sys.exit(1)
  
print("[*] Your safe")

