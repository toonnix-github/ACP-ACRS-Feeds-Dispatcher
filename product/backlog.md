# Backlog

Prioritised list of work items. Items at the top are highest priority.

## Legend
- **Type:** `feature` | `improvement` | `bug` | `tech-debt` | `spike`
- **Size:** `S` (< 1 day) | `M` (1–3 days) | `L` (3–5 days) | `XL` (> 5 days / needs breakdown)

---

## Ready for Dev

| # | Title | Type | Size | Notes |
|---|-------|------|------|-------|
| 1 | App1: implement `/health` and `/health/details` endpoints | feature | S | Public + authenticated |
| 2 | App1: S3 write with feed type + timestamp key structure | feature | M | `{feedType}/{yyyy}/{mm}/{dd}/{uuid}` |
| 3 | App1: SQS enqueue with lightweight message schema | feature | M | Include s3Key, feedType, receivedAt |
| 4 | App2: SQS poll + S3 presigned URL generation | feature | M | TTL configurable per env |
| 5 | App2: EventBridge publish with standard event schema | feature | M | See consumer-onboarding.md for schema |
| 6 | Terraform: consumer module first pass | feature | L | EventBridge rule, DLQ, IAM, CW logs |
| 7 | Terraform: endpoint module first pass | feature | L | ALB rule, auth, S3 prefix |
| 8 | Helm: App1 chart with per-env values | feature | M | DEV / OAT / PROD values files |
| 9 | Helm: App2 chart with per-env values | feature | M | DEV / OAT / PROD values files |
| 10 | ArgoCD: App1 + App2 application manifests | feature | S | DEV first |

## In Progress

| # | Title | Type | Size | Assignee |
|---|-------|------|------|----------|
| — | EKS cluster setup | feature | XL | Platform |

## Planned (Not Yet Ready)

| # | Title | Type | Size | Notes |
|---|-------|------|------|-------|
| 11 | Performance test: baseline pod sizing | spike | M | Target: define requests/limits for App1 + App2 |
| 12 | Deduplication: SQS message dedup via message group ID or idempotency key | improvement | L | Phase 2 |
| 13 | Feed schema validation at ingestion | improvement | M | Reject bad payloads early with 400 |
| 14 | ACP Label Framework: remaining 30% | tech-debt | L | Coordinate with Security team |
| 15 | Cognito deprecation: remove all Cognito dependencies | tech-debt | M | Blocked on EntraID cutover |
| 16 | CloudWatch alarms: DLQ depth, App1/App2 error rate | improvement | S | |
| 17 | Splunk dashboard: FIS / UAT / TEST / MIG | improvement | M | Validate existing dashboards |
