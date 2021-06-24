#!/bin/sh

kubectl delete services $1-service;
kubectl delete deployment $1-deployment; 
git pull; 
envsubst '$EXTERNAL_IP' < srcs/templates/services/grafana.yaml > srcs/grafana/grafana.yaml

docker build $2 -t ft_services_$1 srcs/$1; 
kubectl apply -f srcs/$1/$1.yaml
