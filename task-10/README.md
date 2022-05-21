## Alias
alias k="minikube kubectl --"

## Start pods by hand
k run kubia --image=yurynaumovich/it-academy:v1 --port=8080

## List all pods
k get pods
k get nodes

## More info 
k describe node
k describe pod

## Create from file
k create -f pods.yml

## All services with ip and ports
k get services
k get svc

## More info about services
k describe services web-service

## If use minicube, see ip:port
minikube service web-service --url 

## Delete all deployments
k delete --all deployments
k delete --all pods
