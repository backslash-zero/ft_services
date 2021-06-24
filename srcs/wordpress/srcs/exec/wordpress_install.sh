#!/bin/sh

echo "Configuring..."

cd /var/www/wordpress

wp core is-installed > /dev/null 2>&1
if [[ $? = 0 ]]
then	
	echo "Wordpress already installed"
	ecxit 0
fi

while :
do
	wp core is-installed 2>&1 | grep "Error establishing" > /dev/null
	if [ $? -ne 0 ]
	then
		echo "Database was connected"
		break	
	else
		echo "Connecting database"
		sleep 5
	fi
done

wp core install --url=http://${WORDPRESS_SVC_IP}:${WORDPRESS_SVC_PORT} --title="Célestin's Wordpress running on ft_services" --admin_user=$WP_DB_USER --admin_password=$WP_DB_PASSWD --admin_email=cmeunier@42.fr --skip-email
wp user create user1 user1@example.com --role=editor --user_pass=user1
wp user create user2 user2@example.com --role=author --user_pass=user2
wp user create user3 user3@example.com --role=contributor --user_pass=user3
wp user create user4 user4@example.com --role=subscriber --user_pass=user4
wp option update blogdescription "Well I guess this is the proof that everyhting is working as expected"
