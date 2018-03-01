#!/bin/sh

INSTALL_FOLDER=https://raw.githubusercontent.com/antuneza/vultr-startup/master/
NGINX_FILE=install_nginx.sh
PERCONA_FILE=install_percona_5.7.sh
PHP_FILE=install_php_7.2.sh

export WP_SITE=${WP_SITE:-wordpress}
export WP_DB_USER=${WP_DB_USER:-wordpress}
export WP_DB_PASSWD=${WP_DB_PASSWD:-wpsql}

wget $INSTALL_FOLDER$NGINX_FILE
wget $INSTALL_FOLDER$PERCONA_FILE
wget $INSTALL_FOLDER$PHP_FILE

wget https://wordpress.org/latest.tar.gz 
tar zxvf latest.tar.gz 
sudo mv wordpress /var/www/$WP_SITE
sudo chown -R www-data:www-data /var/www/$WP_SITE
rm latest.tar.gz



