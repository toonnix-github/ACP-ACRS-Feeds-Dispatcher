# Deploy

ArgoCD deployment manifests for the Feeds Dispatcher.

## Why Separate from infra/helm?

Helm charts (`infra/helm/`) define **what can be deployed**.
ArgoCD manifests (`deploy/argocd/`) define **what is deployed right now and where**.

Keeping them separate means:
- Different teams can own each (Platform owns deploy/, Engineering owns infra/helm/)
- Rollbacks are a git revert on this folder only
- Promotion between environments is a PR changing the image tag here

## Environments

Each ArgoCD Application targets a specific environment namespace and values file:

| App | Namespace | Values file |
|-----|-----------|-------------|
| app1-ingestion (dev) | `feeds-dispatcher-dev` | `values-dev.yaml` |
| app1-ingestion (oat) | `feeds-dispatcher-oat` | `values-oat.yaml` |
| app1-ingestion (prod) | `feeds-dispatcher-prod` | `values-prod.yaml` |
| app2-dispatch (dev) | `feeds-dispatcher-dev` | `values-dev.yaml` |
| ... | ... | ... |

## Sync Strategy

- DEV: auto-sync on every push to `main`
- OAT: auto-sync on every push to `main`
- PROD: manual sync — requires explicit ArgoCD approval
