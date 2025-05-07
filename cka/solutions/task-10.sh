# Solution:
# Step 1 - Add ArgoCD Helm repository
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Step 2 - Generate the template without installing CRDs
helm template argocd argo/argo-cd --namespace gitops --create-namespace \
  --set installCRDs=false \
  --set global.image.tag=v2.7.4 > argocd-install.yaml

# Step 3 - Apply the template
kubectl apply -f argocd-install.yaml

# Verify the installation
kubectl get pods -n gitops -l app.kubernetes.io/part-of=argocd