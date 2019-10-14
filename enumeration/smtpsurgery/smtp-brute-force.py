#!/usr/bin/env python
import socket
import sys

print("-------------------------------------------")
print("            SMTP USERS BUTE FORCE")
print("-------------------------------------------")

if len(sys.argv) < 2:
    sys.stderr.write("\n[+] Simple STMP VRFY brute force script\n")
    sys.stderr.write("[+] Usage: " + sys.argv[0] + " <ip addr>\n")
    sys.exit()

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
connect = s.connect((sys.argv[1], 25))
banner = s.recv(1024)
print(banner)

users = open("users.txt", 'r').readlines()
for user in users:
    user = user.rstrip()
    s.send("VRFY " + user + "\n\r")
    rep = s.recv(1024)
    print(rep)

s.close()
