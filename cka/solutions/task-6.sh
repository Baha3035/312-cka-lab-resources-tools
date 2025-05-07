# Solution: Add the sidecar container to the pod
cat <<EOF > log-watcher-with-sidecar.yaml
apiVersion: v1
kind: Pod
metadata:
  name: log-watcher
  namespace: monitoring
spec:
  containers:
  - name: main-app
    image: nginx:stable
    volumeMounts:
    - name: log-volume
      mountPath: /var/log/app
  - name: log-collector
    image: busybox
    command: ["/bin/sh", "-c"]
    args:
    - tail -f -n 5 /var/log/app/application.log;
    volumeMounts:
    - name: log-volume
      mountPath: /var/log/app
  volumes:
  - name: log-volume
    emptyDir: {}
EOF

# Delete the existing pod
kubectl delete pod log-watcher -n monitoring
# Create the new pod with sidecar
kubectl apply -f log-watcher-with-sidecar.yaml

# Verify the sidecar is running
kubectl get pod log-watcher -n monitoring
kubectl logs log-watcher -c log-collector -n monitoring