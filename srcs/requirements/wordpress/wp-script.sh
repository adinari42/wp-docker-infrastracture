#!/bin/sh

sleep 30

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else


	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php
	chown -R www-data:www-data /var/www
	chmod -R 755 /var/www

fi
echo "Wordpress is up and running. Access the website via https://adinari.42.fr/"
echo "<?php phpinfo(); ?>" > test.php
exec "$@"