# Solution:
# Step 1 - Create the PersistentVolumeClaim
cat <<EOF > mariadb-pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mariadb-data
  namespace: databases
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 250Mi
  volumeName: db-pv-001
EOF

kubectl apply -f mariadb-pvc.yaml

# Step 2 - Update the MariaDB deployment manifest
cat <<EOF > /data/mariadb/mariadb-deployment-updated.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mariadb
  namespace: databases
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mariadb
  template:
    metadata:
      labels:
        app: mariadb
    spec:
      containers:
      - name: mariadb
        image: mariadb:10.5
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: "securepassword"
        ports:
        - containerPort: 3306
        volumeMounts:
        - name: data
          mountPath: /var/lib/mysql
      volumes:
      - name: data
        persistentVolumeClaim:
          claimName: mariadb-data
EOF

# Step 3 - Apply the updated manifest
kubectl apply -f /data/mariadb/mariadb-deployment-updated.yaml

# Verify the deployment and PVC
kubectl get pvc -n databases
kubectl get deployment mariadb -n databases