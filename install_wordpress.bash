#!/bin/bash -e

#bash file to install wordpress on debian ?10

apt update
apt-get dist-upgrade -y
apt install ntp wordpress curl apache2 mariadb-server iputils-ping -y

chmod +x /usr/share/doc/wordpress/examples/setup-mysql
/usr/share/doc/wordpress/examples/setup-mysql localhost
mv /etc/wordpress/config-localhost.php  /etc/wordpress/config-default.php

echo "
## Virtual host VirtualDocumentRoot

NameVirtualHost *:80

<VirtualHost *:80>
UseCanonicalName Off
VirtualDocumentRoot /usr/share/wordpress
Options All

# wp-content in /srv/www/wp-content/$0
RewriteEngine On
RewriteRule ^/wp-content/(.*)$ /srv/www/wp-content/%{HTTP_HOST}/$1
</VirtualHost>

RewriteRule ^index\.php$ - [L]
RewriteCond /usr/share/wordpress%{REQUEST_URI} !-f
RewriteCond /usr/share/wordpress%{REQUEST_URI} !-d
RewriteRule . /usr/share/wordpress/index.php [L]
# Also needed if using PHP-FPM / Fast-CGI
RewriteCond %{REQUEST_URI} !^/php5-fcgi/*

" > /etc/apache2/sites-enabled/000-default.conf

/usr/sbin/a2enmod rewrite
/usr/sbin/a2enmod vhost_alias
/usr/bin/systemctl restart apache2

mysql_secure_installation
reboot
