#!/bin/bash

echo "Entered Linux setup"
echo driver: $MINI_DRIVER
./srcs/exec/check_installs.sh
sudo groupadd docker
sudo usermod -aG docker $USER
sudo chown -R $USER $HOME/.kube $HOME/.minikube