# Solution: Install Calico
# 1. Install the Tigera Calico operator
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml

# 2. Create the custom resources needed to configure Calico
cat <<EOF > calico-resources.yaml
apiVersion: operator.tigera.io/v1
kind: Installation
metadata:
  name: default
spec:
  calicoNetwork:
    ipPools:
    - blockSize: 26
      cidr: 192.168.0.0/16
      encapsulation: VXLANCrossSubnet
      natOutgoing: Enabled
      nodeSelector: all()
EOF

kubectl create -f calico-resources.yaml

# 3. Wait for all the pods to be ready
kubectl wait --for=condition=ready pod -l k8s-app=calico-node -n calico-system --timeout=90s

# 4. Verify Calico is working
kubectl get pods -n calico-system