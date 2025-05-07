# Solution: Create the StorageClass
cat <<EOF > data-analytics-storage.yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: data-analytics-storage
  namespace: data-science
provisioner: rancher.io/local-path
volumeBindingMode: WaitForFirstConsumer
reclaimPolicy: Delete
EOF

kubectl apply -f data-analytics-storage.yaml

# Verify the StorageClass
kubectl get storageclass data-analytics-storage