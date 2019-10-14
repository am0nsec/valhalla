#!/bin/bash

echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list && \\
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 && \\
apt-get update && \\
wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u5_amd64.deb && \\
wget https://mirrors.ocf.berkeley.edu/tanglu/pool/main/libg/libgcrypt11/libgcrypt11_1.5.4-3_amd64.deb && \\
dpkg -i libgcrypt11_1.5.4-3_amd64.deb && \\
dpkg -i libssl1.0.0_1.0.1t-1+deb8u5_amd64.deb && \\
apt-get install spotify-client && \\
rm -f libssl1.0.0_1.0.1t-1+deb8u5_amd64.deb && \\
rm -f libgcrypt11_1.5.4-3_amd64.deb && \\
apt-get update && \\
apt-get dist-upgrade && \\
apt-get purge && \\
apt-get autoclean
