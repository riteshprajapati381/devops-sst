#!/usr/bin/env bash
set -euxo pipefail
export PATH="$HOME/.local/bin:$PATH"
cd "$HOME/devops-sst/Helm"
helm lint notes-chart
helm create practice-chart
timeout 45 helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
timeout 45 helm repo update
helm search repo prometheus-community/prometheus | head -5
helm install notes ./notes-chart --namespace helm-homework --create-namespace --wait --timeout 180s
helm list -n helm-homework
helm status notes -n helm-homework
helm get values notes -n helm-homework
helm get manifest notes -n helm-homework
helm upgrade notes ./notes-chart -n helm-homework -f notes-chart/values-prod.yaml --wait --timeout 180s
kubectl get pods,svc -n helm-homework
helm upgrade notes ./notes-chart -n helm-homework --set image.tag=1.27 --set replicaCount=2 --wait --timeout 180s
helm history notes -n helm-homework
helm rollback notes 1 -n helm-homework --wait --timeout 180s
helm history notes -n helm-homework
kubectl get pods,configmap,svc -n helm-homework
