#!/bin/bash
sudo mkdir -p /var/www/VirtualHost
sudo touch /var/www/VirtualHost/index.html
sudo chmod go+w /var/www/VirtualHost/index.html
sudo echo -e ' <!doctype html>\n<html>\n<head>\n <meta charset="utf-8">\n<title>Nginx: Web with VirtualHost server</title>\n</head>\n<body>\n<h1>Welcome to Nginx</h1>\n <p> The virtual host is also Up on  Nginx Web Server </p>\n</body>\n</html>\n' > /var/www/VirtualHost/index.html
sudo touch /etc/nginx/sites-enabled/virtual_host
sudo echo -e 'server {\nlisten 81;\n listen [::]:81;\nserver_name my.virtualhost.com;\nroot /var/www/VirtualHost;\nindex index.html;\nlocation / {\ntry_files $uri $uri/ =404;\n}\n}' > /etc/nginx/sites-enabled/virtual_host