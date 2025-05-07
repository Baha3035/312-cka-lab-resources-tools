# Solution: Step 1 - Create the PriorityClass
cat <<EOF > critical-ops-priority.yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: critical-ops
spec:
  value: 1000000
  globalDefault: false
  description: "For critical operational components"
EOF

kubectl apply -f critical-ops-priority.yaml

# Step 2 - Update the pod to use the PriorityClass
cat <<EOF > ops-controller-with-priority.yaml
apiVersion: v1
kind: Pod
metadata:
  name: ops-controller
  namespace: operations
spec:
  priorityClassName: critical-ops
  containers:
  - name: controller
    image: nginx:stable
    resources:
      requests:
        memory: "64Mi"
        cpu: "100m"
      limits:
        memory: "128Mi"
        cpu: "200m"
EOF

kubectl delete pod ops-controller -n operations
kubectl apply -f ops-controller-with-priority.yaml

# Verify the pod has the PriorityClass
kubectl get pod ops-controller -n operations -o jsonpath='{.spec.priorityClassName}'