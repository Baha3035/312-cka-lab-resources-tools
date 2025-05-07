# Solution: Create the HPA
cat <<EOF > stellar-api-hpa.yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: stellar-api-hpa
  namespace: mission-control
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: stellar-api
  minReplicas: 1
  maxReplicas: 4
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
  behavior:
    scaleDown:
      stabilizationWindowSeconds: 180
EOF

kubectl apply -f stellar-api-hpa.yaml

# Verify the HPA
kubectl get hpa -n mission-control