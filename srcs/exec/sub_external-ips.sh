#!/bin/sh

eval $(minikube docker-env);
export MINIKUBE_IP=$(minikube ip)
export EXTERNAL_IP=$(minikube ip)
echo Minikube IP: $MINIKUBE_IP
if ! type envsubst > /dev/null;
then
	echo "Installing envsubst"
	if [ $OS = "Linux" ] ; then
		apt-get install gettext-base
	else
		brew install gettext
	fi
	echo "Installed envsubst"
fi

envsubst	'$EXTERNAL_IP'	<	srcs/templates/configmaps/metallb-configmap.yaml	> srcs/metallb/metallb-configmap.yaml
cat							<	srcs/templates/configmaps/wp-configmap.yaml			> srcs/metallb/wp-configmap.yaml
envsubst	'$EXTERNAL_IP'	<	srcs/templates/configmaps/grafana-configmap.yaml	> srcs/metallb/grafana-configmap.yaml	
cat							<	srcs/templates/configmaps/telegraf-configmap.yaml	> srcs/metallb/telegraf-configmap.yaml
envsubst	'$EXTERNAL_IP'	<	srcs/templates/services/nginx.yaml					> srcs/nginx/nginx.yaml
envsubst	'$EXTERNAL_IP'	<	srcs/templates/services/wordpress.yaml				> srcs/wordpress/wordpress.yaml
envsubst	'$EXTERNAL_IP'	<	srcs/templates/services/mysql.yaml					> srcs/mysql/mysql.yaml
envsubst	'$EXTERNAL_IP'	<	srcs/templates/services/phpmyadmin.yaml				> srcs/phpmyadmin/phpmyadmin.yaml
envsubst	'$EXTERNAL_IP'	<	srcs/templates/services/ftps.yaml					> srcs/ftps/ftps.yaml	
cat							<	srcs/templates/services/influxdb.yaml				> srcs/influxdb/influxdb.yaml	
cat							<	srcs/templates/services/telegraf.yaml				> srcs/telegraf/telegraf.yaml
envsubst	'$EXTERNAL_IP'	<	srcs/templates/services/grafana.yaml				> srcs/grafana/grafana.yaml