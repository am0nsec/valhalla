#!/bin/bash

mkdir /opt/dictionary/
cd /opt/dictionary/
wget https://crackstation.net/files/crackstation-human-only.txt.gz \
&& wget https://crackstation.net/files/crackstation.txt.gz \
&& gunzip crackstation.txt.gz \
&& gunzip crackstation-human-only.txt.gz
