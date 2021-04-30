apt-get upgrade -y
apt-get upgrade -y
apt-get install -y apache2 php php-mysql default-mysql-server wget zip php7.4-gd nano
systemctl start apache2 mysql
cd /var/www
wget https://github.com/jehy-security/DVWA/archive/master.zip
unzip master.zip
mv DVWA-master/ dvwa
echo "
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
CREATE DATABASE dvwa;
GRANT ALL PRIVILEGES ON * . * TO 'user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
" | mysql -u root -p ""
cd dvwa/
sed "s/'db_user'\(.*\)'root'/'db_user'\1'user'/" config/config.inc.php.dist |
sed "s/'db_password'\(.*\)'\(.*\)'/'db_password'\1'password'/"|
tee config/config.inc.php
chmod 777 hackable/uploads/
cd /etc/apache2/sites-available
sed "s#DocumentRoot /var/www/html#DocumentRoot /var/www/dvwa#" 000-default.conf|
tee 000-default.conf
cd /etc/php/7.4/apache2
sed "s#allow_url_include\(.*\)#allow_url_include = on#" php.ini|
tee php.ini
systemctl restart apache2
