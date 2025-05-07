# Solution:
# Step 1 - Create the Gateway
cat <<EOF > app-gateway.yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: Gateway
metadata:
  name: app-gateway
  namespace: gateway-migration
spec:
  gatewayClassName: istio
  listeners:
  - name: https
    protocol: HTTPS
    port: 443
    tls:
      mode: Terminate
      certificateRefs:
      - name: example-tls-secret
    hostname: gateway.example.com
EOF

kubectl apply -f app-gateway.yaml

# Step 2 - Create the HTTPRoute
cat <<EOF > app-http-route.yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: HTTPRoute
metadata:
  name: app-routes
  namespace: gateway-migration
spec:
  parentRefs:
  - name: app-gateway
  hostnames:
  - gateway.example.com
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /api
    backendRefs:
    - name: api-service
      port: 8080
  - matches:
    - path:
        type: PathPrefix
        value: /web
    backendRefs:
    - name: web-service
      port: 80
EOF

kubectl apply -f app-http-route.yaml

# Verify the Gateway and HTTPRoute
kubectl get gateway -n gateway-migration
kubectl get httproute -n gateway-migration