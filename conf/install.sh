#!/usr/bin/env bash
apt-get update

# Install lamp server
#apt-get install -y lamp-server^

# Install php and mysql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
apt-get install -y mysql-server-5.5 libapache2-mod-auth-mysql php5-mysql php5 libapache2-mod-php5

# Install apache
apt-get install -y apache2
a2enmod rewrite
sed -i s/"\(export APACHE_RUN_USER=\)\(.*\)/\1vagrant/" /etc/apache2/envvars
sed -i s/"\(export APACHE_RUN_GROUP=\)\(.*\)/\1vagrant/" /etc/apache2/envvars
chown -R vagrant:vagrant /var/lock/apache2/
service apache2 restart

# Create sites directory
if [ ! -d /vagrant/sites ]; then
	mkdir /vagrant/sites
fi
if [ ! -r /vagrant/sites/index.html ]; then
	if [ -r /var/www/index.html ]; then
		cp  /var/www/index.html /vagrant/sites/index.html
	else
		echo "Apache is running" > /vagrant/sites/index.html
	fi
fi

# Set up project directory
rm -r /var/www
ln -s /vagrant/sites /var/www

# Download WordPress
# apt-get install unzip
# cd /vagrant
# if [ ! -d sites ]; then
# 	mkdir sites
# fi
# wget -qO wordpress.zip https://wordpress.org/latest.zip
# unzip -qa wordpress.zip -d sites