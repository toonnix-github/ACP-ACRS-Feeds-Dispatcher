# Infrastructure

All infrastructure-as-code for the Feeds Dispatcher.

| Folder | Tool | Purpose |
|--------|------|---------|
| [terraform/](terraform/) | Terraform | AWS resource provisioning (S3, SQS, EventBridge, IAM, ALB rules) |
| [helm/](helm/) | Helm | Kubernetes packaging for App1 and App2 |

## Ownership

- **Terraform modules**: owned by the Engineering team
- **Helm charts**: owned jointly by Engineering and Platform
- **Terraform state**: stored in remote backend (S3 + DynamoDB lock) — not in this repo
- **ECR registry**: Helm charts pushed to ECR as OCI artifacts by CI pipeline

## Environments

Changes flow through: `DEV` → `OAT` → `PROD`

Never apply infrastructure changes directly to PROD without OAT validation.
