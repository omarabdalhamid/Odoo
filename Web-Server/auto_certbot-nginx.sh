#!/bin/bash
################################################################################
# Script for installing ZiSoft on Ubuntu 14.04, 15.04, 16.04 and 18.04 (could be used for other version too)
# Author: OmarAbdalhamid Omar
################################################################################

echo "\n#############################################"

echo  "\n--- Generate SSL CERT --"

echo "\n#############################################"

read -p "Enter Domain Name   "  domain_name

echo "\n"
wget https://dl.eff.org/certbot-auto
sudo mv certbot-auto /usr/local/bin/certbot-auto
sudo chown root /usr/local/bin/certbot-auto
sudo chmod 0755 /usr/local/bin/certbot-auto
service nginx stop
sudo certbot-auto certonly   --standalone -d "$domain_name"
service nginx start
