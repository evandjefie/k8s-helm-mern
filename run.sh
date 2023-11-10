#!/bin/bash

# echo "Build api"
# docker build -t api-todo .

# echo "Tag api"
# docker tag api-server evandjefie/api-todo:1.0

# echo "Push api to Hub"
# docker push evandjefie/api-todo:1.0


minikube kubectl get nodes


# ----------------------------------------------------------------------------


echo "Kubeapps install"

minikube minikube kubectl -- create --namespace default serviceaccount kubeapps-operator

minikube kubectl -- create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator

cat <<EOF | minikube kubectl -- apply -f -
  apiVersion: v1
  kind: Secret
  metadata:
    name: kubeapps-operator-token
    namespace: default
    annotations:
      kubernetes.io/service-account.name: kubeapps-operator
  type: kubernetes.io/service-account-token
EOF

HELM_TOKEN=$(minikube kubectl -- get --namespace default secret kubeapps-operator-token -o go-template='{{.data.token | base64decode}}')

# ----------------------------------------------------------------------------

echo "Get mongodb root pasword"
 export MONGODB_ROOT_PASSWORD=$(kb -- get secret --namespace mern-app todoapp-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 -d)  

echo "Connect to mongo and Create database"
kb -- port-forward --namespace mern-app svc/todoapp-mongodb 27017:27017 &
mongosh --host 127.0.0.1 --authenticationDatabase admin -p $MONGODB_ROOT_PASSWORD --eval 'db.getSiblingDB("todoapp").createUser({user: "evan", pwd: $MONGODB_PASSWORD, roles: [{ role: "readWrite", db: "todoapp" }, { role: "dbAdmin", db: "todoapp" }]})'

echo "Deploy api-todo"

kb -- apply -f server/k8s/mern-deploy.yaml
kb -- apply -f server/k8s/mern-svc.yaml

echo "Expose api-todo to specific port, here 5000"
kb -- port-forward svc/mern-app -n mern-app 5000:80