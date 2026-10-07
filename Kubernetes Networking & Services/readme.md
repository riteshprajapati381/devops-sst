# Kubernetes Networking & Services

## Service types

| Service | Use |
|---|---|
| ClusterIP | Internal access through a stable IP |
| NodePort | Access through a port on the node |
| LoadBalancer | External access using a load balancer |
| ExternalName | DNS alias to an external hostname |
| Headless | Returns Pod endpoint addresses |

```bash
kubectl apply -f manifests/01-clusterip
kubectl apply -f manifests/02-nodeport
kubectl apply -f manifests/03-loadbalancer
kubectl apply -f manifests/04-externalname
kubectl apply -f manifests/05-headless
kubectl get services
kubectl get endpoints web-service-clusterip
kubectl exec curl-client -- curl -s http://web-service-clusterip:8080
kubectl exec dns-test-client -- nslookup external-database-service
kubectl exec headless-dns-client -- nslookup web-service-headless
```

Result: ClusterIP requests and DNS checks passed on the kind cluster. LoadBalancer stayed pending because no external load balancer was configured.

## Kubernetes objects

| Object | Purpose | Scaling, identity and storage |
|---|---|---|
| Deployment | Stateless applications and rolling updates | Replica count; interchangeable Pods |
| ReplicaSet | Maintains matching Pods | Replica count; usually managed by a Deployment |
| DaemonSet | Node agents such as log collectors | One Pod per eligible node; often node-local storage |
| StatefulSet | Stateful workloads | Stable Pod names and individual PVCs |
| Service | Discovery and routing to ready Pods | Does not create or scale Pods |

Deployment manages ReplicaSets, which manage Pods. Service selectors match Pod labels independently.

Research: [FQDN](fqdn/README.md) and [CoreDNS](coredns/README.md).

![ClusterIP service](image/readme/clusterip-service.png)

## Screenshots