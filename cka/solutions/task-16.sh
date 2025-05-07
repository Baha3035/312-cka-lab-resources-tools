# Solution:
# Step 1 - Update the ConfigMap
cat <<EOF > updated-app-config.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: security
data:
  ssl.conf: |
    ssl_protocols TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers 'TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256';
EOF

kubectl apply -f updated-app-config.yaml

# Step 2 - Restart the pod to pick up the new configuration
kubectl delete pod secure-app -n security
kubectl apply -f secure-app-pod.yaml

# Step 3 - Test the TLS configuration
# In a real environment, you would use openssl to test:
# openssl s_client -connect [POD_IP]:443 -tls1_2
# (Should fail)
# openssl s_client -connect [POD_IP]:443 -tls1_3
# (Should succeed)