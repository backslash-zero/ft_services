#!/bin/bash
eval $(minikube docker-env)
while :
do
	export INFLUX_IP=$(kubectl describe service influxdb-service | grep "Endpoints:" | cut -f 2- -d ':' | tr -d '[:blank:]')
	if [[ "$INFLUX_IP" = "<none>" || "$INFLUX_IP" = "" ]] ; then
		sleep 5
		echo "InfluxDB not yet deployed"
	else
		echo "Database was connected"
		break	
	fi
done