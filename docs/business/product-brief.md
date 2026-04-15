# Product Brief — ACP-ACRS Feeds Dispatcher

## What It Is
An event-driven integration layer that receives hotel data feeds from ACRS (Amadeus) and distributes them reliably to multiple internal consumers.

## Problem It Solves
| Problem | Impact |
|---------|--------|
| ACRS tightly coupled to each consumer | Any ACRS change breaks all consumers |
| No reliable retry on delivery failure | Feeds silently dropped |
| Payload size limits in API Gateway | Large feeds (~4–10 MB) could not be delivered |
| Auth costs (Cognito ~$4K/month) | Unnecessary operational expense |
| No visibility into feed delivery | No audit trail, hard to debug failures |

## Value Delivered
| Goal | How |
|------|-----|
| Decouple ACRS from consumers | Single ingestion point; consumers subscribe independently |
| Reliable delivery | SQS retry + DLQ — no feed lost without investigation trail |
| Large payload support | S3 storage; consumers receive presigned URL reference |
| Cost efficiency | EKS replaces Cognito + Lambda; lower per-feed cost at scale |
| Observability | CloudWatch + Splunk dashboards per environment |

## Known Consumers
- **Loyalty** — hotel data for loyalty program processing
- **Data Team** — analytics and data warehouse feeds
- **FastCom** — fast content distribution pipeline

## Environments
| Env | Purpose |
|-----|---------|
| DEV | Development and integration testing |
| OAT | UAT / TEST / MIG / PDT — pre-production validation |
| PROD | Live production traffic |

## Team & Ownership
| Role | Responsibility |
|------|---------------|
| Engineering | App1, App2, infra, CI/CD |
| Platform | EKS, ArgoCD, Helm, ECR |
| Product | Backlog, roadmap, consumer onboarding |
| Security | ACP Label Framework, auth, compliance |

## Current Status
- Migrating from serverless (v1/v2) to EKS (v4)
- Performance testing in progress
- ACP Label Framework ~70% complete
- Target: next PI
