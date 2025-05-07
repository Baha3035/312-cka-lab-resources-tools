# Solution:
# Step 1 - Identify the issue
# In a real environment, you would check:
# - API server logs: sudo journalctl -u kube-apiserver
# - etcd connectivity: sudo systemctl status etcd
# - API server configuration: cat /etc/kubernetes/manifests/kube-apiserver.yaml

# Step 2 - Fix the etcd configuration
# In a real environment, you would update the API server configuration:
sudo mkdir -p /etc/kubernetes/pki/etcd
sudo cp /path/to/working-etcd-ca.crt /etc/kubernetes/pki/etcd/ca.crt
sudo cp /path/to/working-etcd.crt /etc/kubernetes/pki/etcd/server.crt
sudo cp /path/to/working-etcd.key /etc/kubernetes/pki/etcd/server.key

# Update the API server configuration to use the correct etcd endpoint
sudo sed -i 's|--etcd-servers=https://old-etcd-endpoint:2379|--etcd-servers=https://new-etcd-endpoint:2379|g' /etc/kubernetes/manifests/kube-apiserver.yaml

# Step 3 - Restart the kubelet to pick up changes
sudo systemctl restart kubelet

# Step 4 - Verify the cluster is healthy
kubectl get nodes
kubectl get pods --all-namespaces