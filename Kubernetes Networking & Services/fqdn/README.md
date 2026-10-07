# Kubernetes FQDN

A fully qualified domain name specifies the complete DNS name, rather than a short name interpreted relative to a search domain. The usual Service form is `<service>.<namespace>.svc.cluster.local` (the cluster DNS suffix is configurable).

Inside the same namespace, `web-service-clusterip` resolves using the Pod's DNS search domains. From another namespace, use `web-service-clusterip.default` or the full `web-service-clusterip.default.svc.cluster.local`. A normal ClusterIP Service resolves to its stable virtual IP; a headless Service resolves to endpoint addresses. StatefulSet Pods can have stable identities such as `web-0.web-service-headless.default.svc.cluster.local`.

Test with `kubectl exec <client> -- nslookup web-service-clusterip.default.svc.cluster.local` and then `curl` the Service port. DNS resolves a name; Service routing still depends on ready endpoints and matching labels.
