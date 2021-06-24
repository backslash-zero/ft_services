#!/bin/sh

# Replace in config files
RES=0
envsubst '$EXTERNAL_IP' < srcs/metallb/metallb.yaml > srcs/metallb/metallb.yaml
RES=$((RES+$?))
envsubst '$EXTERNAL_IP' < srcs/nginx/nginx.yaml > srcs/nginx/nginx.yaml
RES=$((RES+$?))
envsubst '$EXTERNAL_IP' < srcs/wordpress/wordpress.yaml > srcs/wordpress/wordpress.yaml
RES=$((RES+$?))
envsubst '$EXTERNAL_IP' < srcs/phpmyadmin/phpmyadmin.yaml > srcs/phpmyadmin/phpmyadmin.yaml
RES=$((RES+$?))
if [ $RES -gt 0 ]
then
	echo "\033[31m ERROR: envsubst failed replacing $EXTERNAL_IP in templates \033[0m"
	exit 1
fi