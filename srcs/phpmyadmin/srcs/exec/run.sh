#!/bin/bash

mkdir -p /var/www/phpmyadmin
mkdir /usr/share/phpmyadmin
mkdir /usr/share/phpmyadmin/tmp
mkdir -p /run/nginx
chmod 755 /usr/share/phpmyadmin/tmp

mv phpMyAdmin-5.0.4-all-languages.tar.gz phpmyadmin.tar.gz
tar xzf phpmyadmin.tar.gz --strip-components=1 -C /var/www/phpmyadmin/

sed s/localhost/$WP_DB_HOST/g /var/www/phpmyadmin/config.sample.inc.php > /var/www/phpmyadmin/config.inc.php
echo "\$cfg['PmaAbsoluteUri'] = './';" >> /var/www/phpmyadmin/config.inc.php
echo "\$cfg['AllowThirdPartyFraming'] = 'true';" >> /var/www/phpmyadmin/config.inc.php

rm phpmyadmin.tar.gz

mkdir -p /run/nginx
nginx
status=$?
if [ $status -ne 0 ];
then
	echo "Failed to start nginx: $status"
	exit $status
fi

php-fpm7
status=$?
if [ $status -ne 0 ];
then
	echo "Failed to start php-fpm7: $status"
	exit $status
fi

sleep infinity