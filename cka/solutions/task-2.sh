# Solution: Create the Ingress resource
cat <<EOF > galaxy-messenger-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: galaxy-messenger-ingress
  namespace: comms
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  tls:
  - hosts:
    - messenger.galaxy.com
    - chat.galaxy.com
    secretName: galaxy-tls-cert
  rules:
  - host: messenger.galaxy.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: galaxy-messenger
            port:
              number: 8080
  - host: chat.galaxy.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: galaxy-messenger
            port:
              number: 8080
EOF

kubectl apply -f galaxy-messenger-ingress.yaml

# Verify the Ingress
kubectl get ingress -n comms