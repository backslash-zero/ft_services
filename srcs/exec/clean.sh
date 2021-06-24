#!/bin/bash
echo "Deleting ingresses\n"
kubectl delete --all ingresses
echo "Deleting deployments\n"
kubectl delete --all deployments
echo "Deleting pods\n"
kubectl delete --all pods
echo "Deleting services\n"
kubectl delete --all services
echo "Deleting pvc\n"
kubectl delete --all pvc
echo "Deleting secrets\n"
kubectl delete --all secret

docker rmi -f $(docker images -a -q)
echo "y\n" | docker system prune