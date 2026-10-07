#!/usr/bin/env bash
set -euxo pipefail
export PATH="$HOME/.local/bin:$PATH"
cd "$HOME/devops-sst/Kubernetes Pods, ReplicaSets & Deployments"
kubectl create namespace strategies --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n strategies -f 01-rolling-update/deployment-v1.yaml -f 01-rolling-update/service.yaml
kubectl rollout status deployment/app-rolling -n strategies --timeout=180s
kubectl apply -n strategies -f 01-rolling-update/deployment-v2.yaml
kubectl get pods -n strategies --show-labels
kubectl rollout status deployment/app-rolling -n strategies --timeout=180s
kubectl rollout history deployment/app-rolling -n strategies
kubectl delete -n strategies -f 01-rolling-update/deployment-v1.yaml -f 01-rolling-update/service.yaml
kubectl apply -n strategies -f 02-blue-green/deployment-blue.yaml -f 02-blue-green/deployment-green.yaml -f 02-blue-green/service-blue.yaml
kubectl rollout status deployment/app-blue -n strategies --timeout=180s
kubectl rollout status deployment/app-green -n strategies --timeout=180s
kubectl get endpoints myapp-service -n strategies
kubectl apply -n strategies -f 02-blue-green/service-green.yaml
kubectl get svc myapp-service -n strategies -o jsonpath='{.spec.selector}'
kubectl get endpoints myapp-service -n strategies
kubectl delete -n strategies -f 02-blue-green/deployment-blue.yaml -f 02-blue-green/deployment-green.yaml -f 02-blue-green/service-blue.yaml
kubectl apply -n strategies -f 03-canary/deployment-stable.yaml -f 03-canary/deployment-canary.yaml -f 03-canary/service.yaml
kubectl rollout status deployment/app-stable -n strategies --timeout=180s
kubectl rollout status deployment/app-canary -n strategies --timeout=180s
kubectl get pods -n strategies -l app=myapp-canary --show-labels
kubectl get endpoints myapp-canary-service -n strategies
kubectl delete -n strategies -f 03-canary/deployment-stable.yaml -f 03-canary/deployment-canary.yaml -f 03-canary/service.yaml
kubectl apply -n strategies -f 04-recreate/deployment-v1.yaml -f 04-recreate/service.yaml
kubectl rollout status deployment/app-recreate -n strategies --timeout=180s
kubectl apply -n strategies -f 04-recreate/deployment-v2.yaml
kubectl get pods -n strategies
kubectl rollout status deployment/app-recreate -n strategies --timeout=180s
kubectl get deploy app-recreate -n strategies -o jsonpath='{.spec.strategy}'
kubectl get pods -n strategies --show-labels
