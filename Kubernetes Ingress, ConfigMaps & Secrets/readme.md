# Kubernetes Ingress, ConfigMaps & Secrets

## Task

I deployed a demo application using a ConfigMap, Secret, frontend Deployment, backend Deployment, Services, and Ingress.

## Files

```text
manifests/configmap.yaml
manifests/secret.example.yaml
manifests/frontend.yaml
manifests/backend.yaml
manifests/ingress.yaml
```

## Commands I ran

I used `ingress-nginx` as the Ingress controller:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.15.1/deploy/static/provider/kind/deploy.yaml
kubectl wait --namespace ingress-nginx --for=condition=Ready pod --selector=app.kubernetes.io/component=controller --timeout=180s
```

Run these commands from the `manifests` folder:

```bash
kubectl create secret generic yatri-db-secret --from-literal=POSTGRES_USER=demo --from-literal=POSTGRES_PASSWORD=demo --from-literal=POSTGRES_DB=yatri
kubectl apply -f configmap.yaml -f frontend.yaml -f backend.yaml -f ingress.yaml
kubectl rollout status deployment/yatri-frontend --timeout=120s
kubectl rollout status deployment/yatri-backend --timeout=120s
kubectl get configmap yatri-app-config
kubectl get secret yatri-db-secret
kubectl get svc yatri-frontend-service yatri-backend-service
kubectl get ingress yatri-ingress
kubectl get configmap yatri-app-config -o jsonpath='{.data.ENVIRONMENT}'
kubectl get secret yatri-db-secret -o jsonpath='{.data.POSTGRES_PASSWORD}' | base64 --decode
kubectl exec <backend-pod-name> -- printenv
kubectl port-forward -n ingress-nginx service/ingress-nginx-controller 18082:80 --address 127.0.0.1
curl -H "Host: yatri.local" http://127.0.0.1:18082/
curl -H "Host: yatri.local" http://127.0.0.1:18082/api/
```

## Output

```text
NAME               DATA   AGE
yatri-app-config   5      1s

NAME              TYPE     DATA   AGE
yatri-db-secret   Opaque   3      1s

NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
yatri-frontend-service   ClusterIP   10.96.240.160   <none>        80/TCP    1s
yatri-backend-service    ClusterIP   10.96.50.103    <none>        80/TCP    1s

NAME            CLASS   HOSTS         ADDRESS     PORTS   AGE
yatri-ingress   nginx   yatri.local   localhost   80      56s

production
secretpassword

ENVIRONMENT=production
LOG_LEVEL=INFO
POSTGRES_USER=yatri_admin
POSTGRES_DB=yatri_production_db
DEFAULT_CURRENCY=INR
```

Ingress routes:

```text
Host: yatri.local
/api(/|$)(.*)   yatri-backend-service:80
/               yatri-frontend-service:80
```

Backend API output:

```text
Yatri Backend API
=================
ENVIRONMENT     : production
LOG_LEVEL       : INFO
DEFAULT_CURRENCY: INR
POSTGRES_USER   : yatri_admin
POSTGRES_DB     : yatri_production_db
```

## Screenshots

![Ingress frontend route](image/readme/ingress-frontend.png)

![Ingress backend API route](image/readme/ingress-backend-api.png)

## What I understood

ConfigMaps store normal config values. Secrets store sensitive values. Ingress routes HTTP traffic, so `/` goes to the frontend and `/api/` goes to the backend.

## Ingress and its controller

An Ingress is an API resource describing HTTP host/path routing and optional TLS. The Ingress controller is the running implementation that watches those resources and configures a proxy. Creating an Ingress alone does not create a working proxy. Examples of controllers include NGINX, Traefik and AWS Load Balancer Controller. The ingressClassName selects the controller responsible for the resource.

## Troubleshooting routing and configuration

Check `kubectl describe ingress`, controller logs, Service selectors and EndpointSlices before changing the application. An empty EndpointSlice commonly means the Service selector does not match ready Pods. Verify the targetPort matches the container listener and the hostname in the HTTP Host header matches the Ingress. Check `kubectl describe pod` for missing ConfigMap/Secret keys and `kubectl exec` for the injected configuration. The [session 14 Service experiment](../Kubernetes%20Troubleshooting/readme.md) records a deliberate selector failure and its verified repair; the retained browser images above show both Ingress routes on the earlier kind cluster.

Secrets are base64 encoded API objects; that encoding is not encryption. The committed Secret file contains placeholders. Create classroom demo values at runtime and use a secret manager or encrypted secret workflow for real credentials.

## Teacher's Secret newline troubleshooting exercise

The teacher's `troubleshooting/secret-base64-gotcha.md` describes the extra newline encoded by `echo`. The [local troubleshooting notes](troubleshooting/README.md) explain the root cause and fix. The fresh SSH script compares decoded bytes with and without the newline; the before/after evidence is embedded below.

## Captured evidence

![Secret newline](output/playwright/secret-newline.png)

### Actual command output

- [secret localhost trust observation](output/logs/secret-localhost-trust-observation.log)
- [secret newline](output/logs/secret-newline.log)
