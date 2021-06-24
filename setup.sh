#!/bin/bash

press_enter_to_continue()
{
	printf 'press [ENTER] to continue...'
	read _
}

print_credentials()
{
	cat srcs/passwords.txt
}

sub_externalip()
{
	export MINIKUBE_IP=$(minikube ip)
	export EXTERNAL_IP=$(minikube ip)
	echo Minikube IP: $MINIKUBE_IP
	echo Minikube IP: $EXTERNAL_IP
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
	mkdir srcs/metallb

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
}

build()
{
	echo "Building Images"
	echo
	# Enable docker daemon to be used inside of Minikube instance
	eval $(minikube docker-env)

	# Build containers
	docker build -t ft_services_nginx_base  srcs/nginx_base
	docker build -t ft_services_nginx		srcs/nginx
	docker build -t ft_services_mysql       srcs/mysql
	docker build -t ft_services_wordpress   srcs/wordpress
	docker build -t ft_services_phpmyadmin  srcs/phpmyadmin
	docker build -t ft_services_ftps  		srcs/ftps
	docker build -t ft_services_influxdb  	srcs/influxdb
}

deploy_services()
{
	echo "Getting deployments and services"
	echo

	kubectl apply -f srcs/mysql/mysql.yaml
	kubectl apply -f srcs/wordpress/wordpress.yaml
	kubectl apply -f srcs/phpmyadmin/phpmyadmin.yaml
	kubectl apply -f srcs/ftps/ftps.yaml
	kubectl apply -f srcs/nginx/nginx.yaml
	kubectl apply -f srcs/influxdb/influxdb.yaml
}

prepare_machine()
{
	OS="`uname -s`"
	if [ $OS = "Linux" ] ; then
		open="xdg-open"
		MINI_DRIVER="docker"
		./srcs/exec/linux_setup.sh
	else
		open="open"
		MINI_DRIVER="virtualbox"
		./srcs/exec/macos_setup.sh
	fi
}

setup_lftp()
{
	sudo apt install lftp
	touch ~/.lftprc
	echo "set ssl:verify-certificate no" >> ~/.lftprc
}

enabling_arp()
{
	kubectl get configmap kube-proxy -n kube-system -o yaml | \
	sed -e "s/strictARP: false/strictARP: true/" | \
	kubectl apply -f - -n kube-system
}

apply_secrets(){
	kubectl apply -f srcs/templates/secrets/ftps-secrets.yaml
	kubectl apply -f srcs/templates/secrets/grafana-secrets.yaml
	kubectl apply -f srcs/templates/secrets/mysql-secrets.yaml
	kubectl apply -f srcs/templates/secrets/telegraf-secrets.yaml
}

apply_configmaps()
{
	kubectl apply -f srcs/metallb/grafana-configmap.yaml 
	kubectl apply -f srcs/metallb/metallb-configmap.yaml
	kubectl apply -f srcs/metallb/telegraf-configmap.yaml
	kubectl apply -f srcs/metallb/wp-configmap.yaml 
}

apply_datasources()
{
	docker build -t ft_services_telegraf  	srcs/telegraf
	docker build -t ft_services_grafana  	srcs/grafana
	kubectl apply -f srcs/telegraf/telegraf.yaml
	kubectl apply -f srcs/grafana/grafana.yaml
}


#    ██████ ▄▄▄█████▓ ▄▄▄       ██▀███  ▄▄▄█████▓    ██░ ██ ▓█████  ██▀███  ▓█████ 
#  ▒██    ▒ ▓  ██▒ ▓▒▒████▄    ▓██ ▒ ██▒▓  ██▒ ▓▒   ▓██░ ██▒▓█   ▀ ▓██ ▒ ██▒▓█   ▀ 
#  ░ ▓██▄   ▒ ▓██░ ▒░▒██  ▀█▄  ▓██ ░▄█ ▒▒ ▓██░ ▒░   ▒██▀▀██░▒███   ▓██ ░▄█ ▒▒███   
#    ▒   ██▒░ ▓██▓ ░ ░██▄▄▄▄██ ▒██▀▀█▄  ░ ▓██▓ ░    ░▓█ ░██ ▒▓█  ▄ ▒██▀▀█▄  ▒▓█  ▄ 
#  ▒██████▒▒  ▒██▒ ░  ▓█   ▓██▒░██▓ ▒██▒  ▒██▒ ░    ░▓█▒░██▓░▒████▒░██▓ ▒██▒░▒████▒
#  ▒ ▒▓▒ ▒ ░  ▒ ░░    ▒▒   ▓▒█░░ ▒▓ ░▒▓░  ▒ ░░       ▒ ░░▒░▒░░ ▒░ ░░ ▒▓ ░▒▓░░░ ▒░ ░
#  ░ ░▒  ░ ░    ░      ▒   ▒▒ ░  ░▒ ░ ▒░    ░        ▒ ░▒░ ░ ░ ░  ░  ░▒ ░ ▒░ ░ ░  ░
#  ░  ░  ░    ░        ░   ▒     ░░   ░   ░          ░  ░░ ░   ░     ░░   ░    ░   
#        ░                 ░  ░   ░                  ░  ░  ░   ░  ░   ░        ░  ░
#

# Checking if minikube is already running, and delete any running instances
pgrep minikube > /dev/null 2>&1 ;
if [ $? = 0 ]; then
	minikube delete
fi

# Getting sudo access for the rest of the script
sudo echo "Starting ft_services"

# Making sure nginx and docker are already running
echo "Ensuring your environment is ready"
service nginx stop 2>&1 > /dev/null;
echo $(whoami) | sudo -S chmod 666 /var/run/docker.sock 2>&1 > /dev/null;

# Making sure all scripts are executable inside of containers
chmod 755 srcs/*/srcs/exec/*.sh

# Preparing machine to host cluster
prepare_machine;
setup_lftp;

# Starting minikube
PORT_RANGE="--extra-config=apiserver.service-node-port-range=20-65535"
minikube start --driver=docker $PORT_RANGE
minikube addons enable dashboard

# Getting minikube ip
MINIKUBE_IP=$(minikube ip)
EXTERNAL_IP=$(minikube ip)
echo Minikube IP: $MINIKUBE_IP

# Substitute externals IP and create all yaml files
sub_externalip; 

# Enabling Address Resolution Protocol (ARP)
enabling_arp;

# Adding metallb manually, under the metallb-system namespace
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml

# Memberlist secret contains the secretkey, if not, create one.
kubectl get secret -n metallb-system memberlist
if [ $? != 0 ]
then
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
fi

apply_secrets;
apply_configmaps;
build;
deploy_services;
apply_datasources;

# Open dashboard & external IP
press_enter_to_continue;
echo
echo "Opening external Ip in your browser..."
press_enter_to_continue;
xdg-open http://$EXTERNAL_IP
echo
echo "Launching Dashboard..."
minikube dashboard &
echo
echo
print_credentials;
echo 