#!/bin/bash
echo "Ensuring docker is installed and Running"
which docker > /dev/null
if [[ $? != 0 ]] ; then
    echo "Installing Docker\n"
    apt-get install docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
else
    echo "Docker already installed\n"
fi

echo  "Ensuring kubectl is installed"
which docker > /dev/null
if [[ $? != 0 ]] ; then
    echo "Installing K8s\n"
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
    chmod +x ./kubectl
	$sudo mv ./kubectl /usr/local/bin/kubectl
else
    echo "kubectl already installed\n"
fi

echo "Ensuring minikube version is up-to-date"
if [[ $(minikube version) == *" v1.14."* ]]; then
    echo 'minikube version up-to-date\n'
else 
    echo 'minikube version outdated\nUpdating...'
    curl -LO https://storage.googleapis.com/minikube/releases/v1.14.0/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm minikube-linux-amd64
fi
