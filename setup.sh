#!/bin/bash
set -e

echo "Starting Kubernetes cluster with kind..."
kind create cluster --name gitops-demo

echo "Installing Argo CD into the cluster..."
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "Waiting for Argo CD services to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s

echo "Port-forwarding Argo CD server to localhost:8080..."
kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null 2>&1 &

echo "Retrieving initial Argo CD admin password..."
ARGO_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "Deployment Complete!"
echo "--------------------------------------------------"
echo "Argo CD UI:       https://localhost:8080"
echo "Argo CD Username:   admin"
echo "Argo CD Password:   ${ARGO_PASSWORD}"
echo "--------------------------------------------------"
echo "Use the 'argocd-app.yaml' to deploy the guestbook app via the UI or CLI."