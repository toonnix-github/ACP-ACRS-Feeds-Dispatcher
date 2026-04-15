# Helm Charts

Kubernetes packaging for App1 and App2. One chart per service with per-environment values files.

## Structure

```
helm/
├── app1-ingestion/
│   ├── Chart.yaml
│   ├── values.yaml          # Defaults (not environment-specific)
│   ├── values-dev.yaml      # DEV overrides
│   ├── values-oat.yaml      # OAT overrides
│   ├── values-prod.yaml     # PROD overrides
│   └── templates/           # Kubernetes manifests
└── app2-dispatch/
    └── (same structure)
```

## Versioning

Chart versions follow semver. Bump `version` in `Chart.yaml` with every change. The `appVersion` tracks the container image tag.

## Publishing to ECR

Charts are pushed to ECR as OCI artifacts by the CI pipeline:

```bash
helm package app1-ingestion/
helm push app1-ingestion-{version}.tgz oci://{account}.dkr.ecr.eu-west-1.amazonaws.com/feeds-dispatcher
```

## Local Rendering (dry-run)

```bash
helm template app1-ingestion ./app1-ingestion -f ./app1-ingestion/values-dev.yaml
```
