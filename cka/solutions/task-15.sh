# Solution:
# Step 1 - Get all required cert-manager CRDs
kubectl get crd -o yaml | grep -A1 cert-manager.io > /home/k8s/cert-manager-crds.yaml

# Step 2 - Document the Certificate resource structure
kubectl explain Certificate.spec.subject > certificate-subject-structure.txt

# Step 3 - Create the Certificate resource
cat <<EOF > wildcard-cert.yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: wildcard-cert
  namespace: cert-mgmt
spec:
  secretName: wildcard-tls
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
  dnsNames:
  - "*.example.org"
  subject:
    organizations:
    - Example Organization
EOF

kubectl apply -f wildcard-cert.yaml

# Verify the Certificate
kubectl get certificate -n cert-mgmt