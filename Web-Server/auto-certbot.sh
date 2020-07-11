read -p  "Enter Domain Name : "  domain_name
wget https://dl.eff.org/certbot-auto
sudo mv certbot-auto /usr/local/bin/certbot-auto
sudo chown root /usr/local/bin/certbot-auto
sudo chmod 0755 /usr/local/bin/certbot-auto
certbot-auto certonly   --standalone -d $domain_name
