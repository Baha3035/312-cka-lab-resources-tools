#!/bin/bash

cd cka/env-setup/

kubectl apply -f namespaces.yaml
kubectl apply -f task-1.yaml
kubectl apply -f task-2.yaml
kubectl apply -f task-3.yaml
kubectl apply -f task-8.yaml
kubectl apply -f task-9.yaml
# Create the MariaDB manifest file for task-11 CKA
mkdir -p /home/ec2-user/data/mariadb/
mv mariadb-deployment.yaml /home/ec2-user/data/mariadb/
kubectl apply -f task-10.yaml
kubectl apply -f task-12.yaml
kubectl apply -f task-13.yaml
kubectl apply -f task-14.yaml
kubectl apply -f task-16.yaml

kubectl apply -f nginx-controller.yaml

kubectl get service ingress-nginx-controller --namespace=ingress-nginx -o jsonpath='{.spec.clusterIP}' | sudo awk '{print $0, "k8s.local"}' >> /etc/hosts
kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' | sudo awk '{print $0, "k8s-cp"}' >> /etc/hosts
# Install Gateway API CRDs for task 12 CKA
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v0.8.0/standard-install.yaml

# Create a file in the log directory for task 6 CKA
kubectl exec -n monitoring log-watcher -- sh -c "mkdir -p /var/log/app && echo 'Sample log line 1' > /var/log/app/application.log && echo 'Sample log line 2' >> /var/log/app/application.log"

# Install cert-manager CRDs for task 15 CKA
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.crds.yaml

# Create the network policy options for task 13 CKA
mkdir -p /data/network-policies/

mkdir /home/ec2-user/kubeship/
mkdir /home/ec2-user/kubeship/1/
mkdir /home/ec2-user/kubeship/3/
mkdir /home/ec2-user/kubeship/6/
mkdir /home/ec2-user/kubeship/9/
mkdir /home/ec2-user/kubeship/12/
mkdir /home/ec2-user/kubeship/13/
mkdir /home/ec2-user/kubeship/14/
mkdir /home/ec2-user/kubeship/15/
mkdir /home/ec2-user/kubeship/15/build/
mkdir /home/ec2-user/kubeship/15/images/

cp task-1.yaml /home/ec2-user/kubeship/1/alpha-1-deployment.yaml
cp task-3-deployment-manifest.yaml /home/ec2-user/kubeship/3/hyper-v-deployment.yaml
cp task-6.yaml /home/ec2-user/kubeship/6/orion-ops.yaml
cp task-9.yaml /home/ec2-user/kubeship/9/cosmic-whale.yaml
cp task-12-deployment-manifest.yaml /home/ec2-user/kubeship/12/deployment.yaml
cp task-12-ingress-manifest.yaml /home/ec2-user/kubeship/12/ingress.yaml
cp task-12-service-manifest.yaml /home/ec2-user/kubeship/12/service.yaml
cp task-13-deployment-manifest.yaml /home/ec2-user/kubeship/13/galactix-db.yaml
cp task-14-deployment-manifest.yaml /home/ec2-user/kubeship/14/current-stellar-deployment.yaml
cp Dockerfile /home/ec2-user/kubeship/15/build/Dockerfile

chown -R ec2-user:ec2-user /home/ec2-user/kubeship/