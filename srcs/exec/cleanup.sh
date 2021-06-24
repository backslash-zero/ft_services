eval $(minikube docker-env)
./srcs/exec/clean.sh
minikube delete
# rm -rf ~/.minikube