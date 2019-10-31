

NginX 

![Nginx](https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQnTmaEiNDx9JEPClSC5eww0gCwEmirMSnUvihu6PqG4LYuitgH)

You have Odoo installed, if not you can find the instructions here
You have a domain name pointing to your Odoo installation. In this article we will use odoo.example.com.
You have Nginx installed, if not check this guide.
You have a SSL certificate installed for your domain. You can install a free Let’s Encrypt SSL certificate by following this guide.
Configure Nginx as a Reverse Proxy
Using a reverse proxy gives you a lot of benefits such as Load Balancing, SSL Termination, Caching, Compression, Serving Static Content and more.

In this example we will configure SSL Termination, HTTP to HTTPS redirection, cache the static files and enable GZip compression.


Below is a sample nginx configuration file (server block) that you can use for your Odoo installation. All the HTTP requests will be redirected to HTTPS.

Open your text editor and create the following file:

sudo nano /etc/nginx/sites-enabled/odoo.example.com
/etc/nginx/sites-enabled/odoo.example.com


upstream odoo {
 server 127.0.0.1:8069;
}

upstream odoo-chat {
 server 127.0.0.1:8072;
}

server {
    server_name odoo.example.com;
    return 301 https://odoo.example.com$request_uri;
}

server {
   listen 443 ssl http2;
   server_name odoo.example.com;

   ssl_certificate /path/to/signed_cert_plus_intermediates;
   ssl_certificate_key /path/to/private_key;
   ssl_session_timeout 1d;
   ssl_session_cache shared:SSL:50m;
   ssl_session_tickets off;

   ssl_dhparam /path/to/dhparam.pem;

   ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
   ssl_ciphers 'ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA:ECDHE-RSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-RSA-AES256-SHA256:DHE-RSA-AES256-SHA:ECDHE-ECDSA-DES-CBC3-SHA:ECDHE-RSA-DES-CBC3-SHA:EDH-RSA-DES-CBC3-SHA:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA256:AES256-SHA256:AES128-SHA:AES256-SHA:DES-CBC3-SHA:!DSS';
   ssl_prefer_server_ciphers on;

   add_header Strict-Transport-Security max-age=15768000;

   ssl_stapling on;
   ssl_stapling_verify on;
   ssl_trusted_certificate /path/to/root_CA_cert_plus_intermediates;
   resolver 8.8.8.8 8.8.4.4;

   access_log /var/log/nginx/odoo.access.log;
   error_log /var/log/nginx/odoo.error.log;

   proxy_read_timeout 720s;
   proxy_connect_timeout 720s;
   proxy_send_timeout 720s;
   proxy_set_header X-Forwarded-Host $host;
   proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
   proxy_set_header X-Forwarded-Proto $scheme;
   proxy_set_header X-Real-IP $remote_addr;

   location / {
     proxy_redirect off;
     proxy_pass http://odoo;
   }

   location /longpolling {
       proxy_pass http://odoo-chat;
   }

   location ~* /web/static/ {
       proxy_cache_valid 200 90m;
       proxy_buffering    on;
       expires 864000;
       proxy_pass http://odoo;
  }

  # gzip
  gzip_types text/css text/less text/plain text/xml application/xml application/json application/javascript;
  gzip on;
}


Don’t forget to replace odoo.example.com with your Odoo domain and set the correct path for the SSL certificate files.

Once you are done save the file and restart the Nginx service with:

sudo systemctl restart nginx

Change the binding interface

This step is optional, but it is a good security practice.

By default, Odoo server listens to port 8069 on all interfaces. If you want to disable direct access to your Odoo instance open the Odoo configuration file and add the following two lines at the end of the file:

/etc/odoo.conf
xmlrpc_interface = 127.0.0.1
netrpc_interface = 127.0.0.1
