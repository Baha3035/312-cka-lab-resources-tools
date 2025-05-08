#!/bin/bash
# CKA 2025 Lab Environment Setup Script

# Create all required namespaces
echo "Creating namespaces..."
kubectl apply -f cka/env-setup/namespaces.yaml

# Install required CRDs and controllers
echo "Installing Gateway API CRDs..."
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v0.8.0/standard-install.yaml

echo "Installing cert-manager CRDs..."
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.crds.yaml

echo "Installing NGINX Ingress Controller..."
kubectl apply -f cka/env-setup/nginx-controller.yaml

echo "Installing metrics-server for HPA..."
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Add host entries for DNS resolution
echo "Setting up host entries..."
kubectl get service ingress-nginx-controller --namespace=ingress-nginx -o jsonpath='{.spec.clusterIP}' | sudo tee -a /etc/hosts
echo " k8s.local" | sudo tee -a /etc/hosts
kubectl get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}' | sudo tee -a /etc/hosts
echo " k8s-cp" | sudo tee -a /etc/hosts

# Setup for task-specific environments
echo "Setting up task environments..."

# Setup for Task 1: HPA
kubectl apply -f cka/env-setup/task-1.yaml

# Setup for Task 2: Ingress
kubectl apply -f cka/env-setup/task-2.yaml

# Setup for Task 3: K8s Installation Prerequisites (containerized environment)
echo "Setting up Task 3 environment..."
kubectl apply -f cka/env-setup/task-3.yaml
# Wait for the ubuntu pod to be ready
kubectl wait --for=condition=ready pod k8s-prereq-host -n kube-system --timeout=120s

# Setup for Task 4: CNI Plugin Installation (containerized environment)
echo "Setting up Task 4 environment..."
kubectl apply -f cka/env-setup/task-4.yaml
# Wait for the cni-test-host to be ready
kubectl wait --for=condition=ready pod cni-test-host -n kube-system --timeout=120s

# Setup for Task 5: Resource Management
kubectl apply -f cka/env-setup/task-5.yaml

# Setup for Task 6: Logging with Sidecar
kubectl apply -f cka/env-setup/task-6.yaml
# Create a file in the log directory
kubectl exec -n monitoring log-watcher -- sh -c "mkdir -p /var/log/app && echo 'Sample log line 1' > /var/log/app/application.log && echo 'Sample log line 2' >> /var/log/app/application.log"

# Setup for Task 8: Service Exposure
kubectl apply -f cka/env-setup/task-8.yaml

# Setup for Task 9: Priority Classes
kubectl apply -f cka/env-setup/task-9.yaml

# Setup for Task 11: Persistent Volume Recovery
echo "Setting up Task 11 environment..."
kubectl apply -f cka/env-setup/task-11.yaml
# Create the MariaDB manifest file directory
mkdir -p /home/ec2-user/data/mariadb/
cp cka/env-setup/mariadb-deployment.yaml /home/ec2-user/data/mariadb/

# Setup for Task 12: Gateway API Migration
kubectl apply -f cka/env-setup/task-12.yaml

# Setup for Task 13: Network Policy Selection
kubectl apply -f cka/env-setup/task-13.yaml
# Create the network policy options directory
mkdir -p /data/network-policies/
cp cka/env-setup/policy-option1.yaml /data/network-policies/
cp cka/env-setup/policy-option2.yaml /data/network-policies/
cp cka/env-setup/policy-option3.yaml /data/network-policies/

# Setup for Task 14: Cluster Recovery (containerized environment)
echo "Setting up Task 14 environment..."
kubectl apply -f cka/env-setup/task-14.yaml
# Wait for the cluster-recovery pod to be ready
kubectl wait --for=condition=ready pod cluster-recovery-host -n kube-system --timeout=120s

# Setup for Task 15: Certificate Manager
kubectl apply -f cka/env-setup/task-15.yaml

# Setup for Task 16: TLS Configuration Update
kubectl apply -f cka/env-setup/task-16.yaml

echo "Creating directories for student files..."
mkdir -p /home/ec2-user/cka-tasks
chmod -R 777 /home/ec2-user/cka-tasks

echo "Environment setup complete!"