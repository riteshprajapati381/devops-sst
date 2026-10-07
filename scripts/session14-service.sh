#!/usr/bin/env bash
set -euxo pipefail
export PATH="$HOME/.local/bin:$PATH"
kubectl patch svc troubleshooting-service -n troubleshooting --type=merge -p '{"spec":{"selector":{"app":"wrong-label"}}}'
for attempt in $(seq 1 30); do
 addresses=$(kubectl get endpointslices -n troubleshooting -l kubernetes.io/service-name=troubleshooting-service -o jsonpath='{.items[*].endpoints[*].addresses[*]}')
 test -z "$addresses" && break
 sleep 2
done
kubectl get endpoints troubleshooting-service -n troubleshooting
kubectl patch svc troubleshooting-service -n troubleshooting --type=merge -p '{"spec":{"selector":{"app":"troubleshooting-app"}}}'
for attempt in $(seq 1 30); do
 addresses=$(kubectl get endpointslices -n troubleshooting -l kubernetes.io/service-name=troubleshooting-service -o jsonpath='{.items[*].endpoints[*].addresses[*]}')
 test -n "$addresses" && break
 sleep 2
done
kubectl get endpoints troubleshooting-service -n troubleshooting
kubectl exec -n troubleshooting fail-4-dns-failure-pod -- wget -qO- http://troubleshooting-service | head -6
