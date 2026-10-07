# Helm

A chart packages Kubernetes resources. A release is an installed chart. `notes-chart/` contains Deployment, Service and ConfigMap templates with development and production values.

```bash
helm create sample-chart
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm search repo prometheus-community
helm lint notes-chart
helm install notes ./notes-chart -n helm-homework --create-namespace
helm upgrade notes ./notes-chart -n helm-homework -f notes-chart/values-prod.yaml
helm upgrade notes ./notes-chart -n helm-homework --set image.tag=1.27 --set replicaCount=2
helm history notes -n helm-homework
helm get values notes -n helm-homework
helm get manifest notes -n helm-homework
helm rollback notes 1 -n helm-homework
helm status notes -n helm-homework
helm uninstall notes -n helm-homework
```

Result: install, two upgrades and rollback passed. Rollback restored revision 1's configuration and created revision 4. The release was uninstalled afterward.

## Screenshots

![Upgrade rollback](output/screenshots/upgrade-rollback.png)

## Command output

- [helm](output/logs/helm.log)
