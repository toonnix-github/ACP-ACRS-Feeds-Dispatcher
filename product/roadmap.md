# Roadmap

## Current PI — EKS Migration (v4)

| Item | Owner | Status |
|------|-------|--------|
| App1 (Ingestion) service — containerised | Engineering | In Progress |
| App2 (Dispatch) service — containerised | Engineering | In Progress |
| ALB setup + path-based routing | Platform | In Progress |
| Terraform modules (consumer, endpoint) | Engineering | In Progress |
| Helm charts for App1 + App2 | Platform | In Progress |
| ArgoCD pipelines DEV / OAT / PROD | Platform | In Progress |
| Performance testing (pod sizing) | Engineering | Planned |
| ACP Label Framework completion | Engineering + Security | In Progress (~70%) |
| Cognito deprecation | Engineering | Planned |
| CloudWatch + Splunk dashboards validation | Engineering | In Progress |

## Next PI

| Item | Priority | Notes |
|------|----------|-------|
| Deduplication layer | Medium | SQS delivers at-least-once; consumers currently handle this |
| Feed schema validation | Medium | Validate payload structure at ingestion, reject malformed feeds early |
| Self-service consumer onboarding portal | Low | ServiceNow → Terraform auto-provisioning |
| Multi-region failover | Low | Long-term resilience goal |

## Completed

| Item | PI | Notes |
|------|----|-------|
| Repo structure & full documentation | Current PI | Merged — docs, ADRs, runbooks, onboarding guides |
| Architecture diagrams (Mermaid) | Current PI | Merged — in README and docs/architecture/overview.md |
| Terraform modules (consumer, endpoint) | Current PI | Merged — starter templates ready |
| Helm charts — App1 & App2 | Current PI | Merged — with per-env values files |
| ArgoCD manifests — DEV / OAT / PROD | Current PI | Merged |
| Claude Sr. Engineer auto-review workflow | Current PI | Merged — triggers on every PR |
| Gzip support (workaround) | Past | Replaced by native handling in App1 |
| EventBridge fan-out for Loyalty, Data Team, FastCom | Past | Live in PROD |
| DLQ setup per consumer | Past | Live in PROD |
