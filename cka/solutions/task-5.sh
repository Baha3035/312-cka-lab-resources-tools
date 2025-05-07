# Solution: Update the deployment with proper resource settings
cat <<EOF > wordpress-resources.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wordpress-main
  namespace: web-apps
spec:
  replicas: 3
  selector:
    matchLabels:
      app: wordpress
  template:
    metadata:
      labels:
        app: wordpress
    spec:
      initContainers:
      - name: init-wp-config
        image: busybox
        command: ['sh', '-c', 'echo "Initializing WordPress configs..."']
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
      containers:
      - name: wordpress
        image: wordpress:5.7
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "128Mi"
            cpu: "100m"
          limits:
            memory: "256Mi"
            cpu: "200m"
EOF

# Temporarily scale down the deployment to apply changes
kubectl scale deployment wordpress-main -n web-apps --replicas=0
# Wait for scale down
kubectl wait --for=delete pods --selector=app=wordpress -n web-apps --timeout=60s
# Apply the updated configuration
kubectl apply -f wordpress-resources.yaml

# Verify the changes
kubectl get deployment wordpress-main -n web-apps -o jsonpath='{.spec.template.spec.containers[0].resources}'