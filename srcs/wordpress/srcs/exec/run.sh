#!/bin/sh

cd /var/www/wordpress

mv  ./wp-config-sample.php wp-config.php
sed -i "s/database_name_here/${WP_DB_NAME}/"    wp-config.php
sed -i "s/password_here/${WP_DB_PASSWD}/"       wp-config.php
sed -i "s/username_here/${WP_DB_USER}/"         wp-config.php
sed -i "s/localhost/${WP_DB_HOST}:3306/"        wp-config.php
sed -i "s/'wp_'/'wp_db_'/"                      wp-config.php

cd -
su -s /bin/sh -c "wordpress_install.sh" nginx
supervisord

/usr/sbin/pod_crash.sh;
if [ $1 -ne 0 ]; then
    exit 1
fi

sleep infinity