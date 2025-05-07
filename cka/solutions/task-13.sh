# Solution:
# First, investigate the frontend and backend services
kubectl get pods -n microservices -l app=frontend
kubectl get pods -n microservices -l app=backend
kubectl get svc -n microservices

# Analyze the network policy options
# Option 1 is too permissive (allows all traffic)
# Option 3 is too restrictive (only allows traffic from default and kube-system)
# Option 2 is the most appropriate (allows frontend to backend communication with specific port)
kubectl apply -f /data/network-policies/policy-option2.yaml

# Verify the NetworkPolicy
kubectl get networkpolicy -n microservices
kubectl describe networkpolicy frontend-backend-policy -n microservices