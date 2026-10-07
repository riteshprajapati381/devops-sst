#!/usr/bin/env bash
set -euxo pipefail
export PATH="$HOME/.local/bin:$PATH"
minikube status
kubectl cluster-info
kubectl get nodes -o wide
kubectl apply -f "$HOME/devops-sst/Kubernetes Fundamentals/hello.yml"
sleep 8
kubectl get pods
kubectl logs hello-pod
