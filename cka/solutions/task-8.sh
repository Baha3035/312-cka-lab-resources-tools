# Solution: Step 1 - Update the Deployment to expose port 80
cat <<EOF > frontend-app-with-port.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend-app
  namespace: web-frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: nginx
        image: nginx:stable
        ports:
        - containerPort: 80
EOF

kubectl apply -f frontend-app-with-port.yaml

# Step 2 - Create the Service to expose the Deployment
cat <<EOF > frontend-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend-svc
  namespace: web-frontend
spec:
  selector:
    app: frontend
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
EOF

kubectl apply -f frontend-svc.yaml

# Verify the service
kubectl get svc frontend-svc -n web-frontend