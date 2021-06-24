# FT_SERVICES

## What are we building?

## Cluster
A _cluster_ is a group of inter-connected computers that work together to perform computationally intensive tasks. In a cluster, each computer is referred to as a _node_.

### Kubernetes
Kubernetes, also known as K8s, is an open-source system for automating deployment, scaling, and management of containerized services.

### Minikube
Minikube is a local kubernetes. 

### Docker
Docker is a set of platform as a service products that use OS-level virtualization to deliver software in packages called containers.

We use docker to download and run minikube (with K8 already installed on it), and to build our different applications that will run withing or cluster.

We build each container with a `docker build ` command and add the service to our cluster with `kubectl apply`

### Docker daemon
When using a container or VM driver, you can reuse the Docker daemon inside minikube cluster. This means you don’t have to build on your host machine and push the image into a docker registry. You can just build inside the same docker daemon as minikube which speeds up local experiments. We point to our terminal to the docker daemon using `eval $(minikube docker-env)`

### Load Balancer
A load balancer is a device that acts as a reverse proxy and distributes network or application traffic across a number of servers. Load balancers are used to increase capacity (concurrent users) and reliability of applications.


We will be using _metalLB_ that is specific to K8

Should be cluster's only entry-point.  
*Load Balancer:*`FTPS`, `Grafana`, `nginx`, `phpMyAdmin`, `Wordpress`  
*ClusterIP:* `InfluxDB`, `MySQL`


## Services
All services will have their own dedicated containers, each one running under Alpine Linux.  

### Kubernetes Dashboard
In case of a crash of one of the 2 database containers, we need to make sure the data persists. Each container should be able to restart automatically if it crashes.

### nginx
Web server. Should be accessible via SSH.  
[How To Install Nginx web server on Alpine Linux](https://www.cyberciti.biz/faq/how-to-install-nginx-web-server-on-alpine-linux/)  
[Setting up SSL certification](https://medium.com/faun/setting-up-ssl-certificates-for-nginx-in-docker-environ-e7eec5ebb418)  
[Create a Self-Signed Certificate for Nginx in 5 Minutes](https://www.humankode.com/ssl/create-a-selfsigned-certificate-for-nginx-in-5-minutes)  
`Open on port 80(http) and 443(https) with auto 301 redirection.`

### FTPS
FTPS is an extension to the commonly used File Transfer Protocol that adds support for the Transport Layer Security.  
`Open on port 21.`

### Wordpress
Working with MySQL database. 1 admin and different users.  
`Open on port 5050.`

### MySQL
Database

### PHPMyAdmin
Link to the SQL database.  
`On port 5000`

### Grafana
Accessible on port 3000 working with influxDB. One Dashboard / Container.  
`On port 3000`

### InfluxDB
Time Database

## Other

### Secrets
Kubernetes Secrets let you store and manage sensitive information, such as passwords, OAuth tokens, and ssh keys. Storing confidential information in a Secret is safer and more flexible than putting it verbatim in a Pod definition or in a container image. See Secrets design document for more information.

A Secret is an object that contains a small amount of sensitive data such as a password, a token, or a key. Such information might otherwise be put in a Pod specification or in an image. Users can create Secrets and the system also creates some Secrets.