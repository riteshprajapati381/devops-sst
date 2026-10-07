# CoreDNS

CoreDNS implements cluster DNS and Kubernetes Service discovery. Its Kubernetes plugin watches Services and endpoint information; its forwarding plugin handles names outside the cluster through configured upstream resolvers. Pod resolv.conf normally points to the cluster DNS Service and contains namespace/cluster search domains.

Inspect configuration with `kubectl get configmap coredns -n kube-system -o yaml`. Inspect DNS pods using `kubectl get pods -n kube-system -l k8s-app=kube-dns` and their logs. Check the DNS Service/endpoints, client resolv.conf, the exact namespace and spelling, network policies, and UDP/TCP port 53 connectivity when resolving a name fails.

`kubectl exec <client> -- nslookup <service>.<namespace>.svc.cluster.local` distinguishes a DNS-resolution failure from HTTP port/routing errors. For ExternalName, verify the CNAME chain and target name; it does not proxy traffic.
