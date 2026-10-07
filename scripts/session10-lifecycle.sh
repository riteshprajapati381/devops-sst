#!/usr/bin/env bash
set -euxo pipefail
export PATH="$HOME/.local/bin:$PATH"
cd "$HOME/devops-sst/Kubernetes Pods, ReplicaSets & Deployments"
kubectl create namespace lifecycle --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n lifecycle -f pod-lifecycle/
sleep 40
kubectl get pods -n lifecycle -o wide
kubectl explain pod.spec.restartPolicy
for pod in $(kubectl get pods -n lifecycle -o name); do
  kubectl describe -n lifecycle "$pod"
  kubectl logs -n lifecycle "$pod" --all-containers=true --tail=8 || true
done
kubectl get events -n lifecycle --sort-by=.lastTimestamp | tail -30
