

Odoo Install Script


![odoo12](https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSlIjKbcztRfHeESYwR7h3soSocWTKRBEKn_FFlabfx8QNjlKLF)

 

Modify the parameters as you wish.
There are a few things you can configure, this is the most used list:
OE_USER will be the username for the system user.
INSTALL_WKHTMLTOPDF set to False if you do not want to install Wkhtmltopdf, if you want to install it you should set it to True.
OE_PORT is the port where Odoo should run on, for example 8069.
OE_VERSION is the Odoo version to install, for example 13.0 for Odoo V13.
IS_ENTERPRISE will install the Enterprise version on top of 13.0 if you set it to True, set it to False if you want the community version of Odoo 13.
OE_SUPERADMIN is the master password for this Odoo installation.

3. Make the script executable
sudo chmod +x odoo_install.sh
4. Execute the script:
sudo ./odoo_install.sh


Odoo Install without Script


. Connect to your server
To connect to your server via SSH as user root, use the following command:

ssh root@IP_ADDRESS -p PORT_NUMBER
and replace “IP_ADDRESS” and “PORT_NUMBER” with your actual server IP address and SSH port number.

Once logged in, make sure that your server is up-to-date by running the following commands:

apt-get update
apt-get upgrade
2. Install PostgreSQL Server
We will be using PostgreSQL as a database server for our Odoo application. To install PostgreSQL on your server, run the following command:

apt-get install postgresql -y
3. Enable PostgreSQL on Start Up
After the installation is complete, make sure to enable the PostgreSQL server to start automatically upon server reboot with:

systemctl enable postgresql
4. Install Odoo on Debian 9
Because Odoo is not available in the official Debian 9 repository, we will need to manually add the Odoo repository before we can do the installation. To do this, run the following commands:

wget -O - https://nightly.odoo.com/odoo.key | apt-key add -
echo "deb http://nightly.odoo.com/12.0/nightly/deb/ ./" >> /etc/apt/sources.list.d/odoo.list
Update the list of available packages with:

apt-get update
And run the following command to install Odoo, along with Python and all required Python modules:

apt-get install odoo
After the installation is complete, you can run the following command to check the status of your Odoo service:

systemctl status odoo
Output:

● odoo.service - Odoo Open Source ERP and CRM
Loaded: loaded (/lib/systemd/system/odoo.service; enabled; vendor preset: enabled)
Active: active (running) since Wed 2018-10-10 10:59:04 CDT; 4s ago
Main PID: 10951 (odoo)
CGroup: /system.slice/odoo.service
└─10951 /usr/bin/python3 /usr/bin/odoo --config /etc/odoo/odoo.conf --logfile /var/log/odoo/odoo-server.log
You will also need to set a new master password. To do this you need to edit the Odoo configuration file with:

nano /etc/odoo/odoo.conf
And change admin_password field with a strong password. You can also generate one from the command line.

admin_passwd = StrongPassword
After you made the changes, restart your Odoo with:

systemctl restart odoo
To access Odoo, you can now open your browser and navigate to http://your-server-IP:8069

5. Setting up Apache as a Reverse Proxy
If you have a valid domain name and you would like to use it in order to access your Odoo application instead of typing the IP address and the port number in the URL, we will now show you how to set up a reverse proxy using the Apache web server.

We will start by installing the Apache web server. Apache is considered as the most widely used web server software. It is fast, secure, reliable and can be easily customized depending on your needs.

To install Apache on your server, run the following command:

apt-get install apache2
After the installation is complete, you should enable Apache to start automatically upon system boot. You can do that with the following command:

systemctl enable apache2
To verify that Apache is running, open your web browser and enter your server IP address, (e.g. http://111.222.333.444). If Apache is successfully installed you should see a message saying “It works!”.

Next, we will need to enable some additional proxy modules for Apache. You can do this with the following commands:

a2enmod proxy
a2enmod proxy_http
Once this is done, open a new configuration file for your domain with the following command:

nano /etc/apache2/sites-available/my_domain.conf
And enter the following:

<VirtualHost *:80>
ServerName my_domain.com
ServerAlias www.my_domain.com

ProxyRequests Off
<Proxy *>
Order deny,allow
Allow from all
</Proxy>

ProxyPass / http://my_domain.com:8069/
ProxyPassReverse / http://my_domain.com:8069/
<Location />
Order allow,deny
Allow from all
</Location>
</VirtualHost>
Enable “my_domain.conf” configuration in Apache using:

ln -s /etc/apache2/sites-available/my_domain.conf /etc/apache2/sites-enabled/my_domain.conf
6. Restart Apache Web Server
Remember to replace your my_domain.com’ with your actual domain name. Save the file, close it and restart Apache for the changes to take effect:

service apache2 restart
That’s it. If you followed all the instructions properly you can now access your Odoo 12 using your domain name at http://my_domain.com



