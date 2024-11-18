#!/bin/bash

#Cap nhat va nang cap
sudo apt-get update
sudo apt-get upgrade
#Cai dat Postfix
sudo apt-get install postfix
#Cai dat mailutils -y
sudo apt-get install mailutils -y
#Cai dat dovecot
sudo apt-get install dovecot-core dovecot-imapd dovecot-pop3d -y
#Cai dat apache
sudo apt-get install apache2 -y
#Them php repo
sudo add-apt-repository ppa:ondrej/php -y
#Cai dat php
sudo apt-get install php7.4 -y
#Cai dat squirrelmail
wget http://downloads.sourceforge.net/project/squirrelmail/stable/1.4.22/squirrelmail-webmail-1.4.22.zip	
unzip squirrelmail-webmail-1.4.22.zip
sudo mv squirrelmail-webmail-1.4.22 /var/www/html/
sudo chown -R www-data:www-data /var/www/html/squirrelmail-webmail-1.4.22/
sudo chown 755 -R /var/www/html/squirrelmail-webmail-1.4.22/
sudo mv /var/www/html/squirrelmail-webmail-1.4.22/ /var/www/html/squirrelmail/
sudo perl /var/www/html/squirrelmail/config/conf.pl
sudo echo "mydomain = " >> /etc/postfix/main.cf
read -p "Nhap duoi mail ma ban muon: " NEW_DOMAIN
sudo sed -i "s/^mydomain = .*/mydomain = $NEW_DOMAIN/" /etc/postfix/main.cf
read -p "Nhap ten may chu mail: " NEW_NAME
sudo sed -i "s/^myhostname = .*/myhostname = $NEW_NAME/" /etc/postfix/main.cf
sudo sed -i "s/^mydestination = .*/mydestination = $NEW_NAME, localhost.$NEW_DOMAIN, localhost, $NEW_DOMAIN/" /etc/postfix/main.cf
