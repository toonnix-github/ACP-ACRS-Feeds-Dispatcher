# ADR-0002: Move from Serverless to EKS

## Status
Accepted

## Context
The v1/v2 architecture (API Gateway + Lambda + Cognito) hit multiple scaling and cost ceilings:

- Cognito auth APIs throttle at ~120 RPS, blocking high-throughput feed ingestion
- Lambda cold starts introduce latency spikes under bursty load
- API Gateway imposes a ~6 MB payload limit (see ADR-0001)
- Cognito cost reached ~$4K/month for auth alone
- Per-endpoint configuration toggles (e.g., Gzip support) created operational overhead

The team already operates EKS for other workloads, so operational expertise and tooling (ArgoCD, Helm, ECR scanning) are available.

## Decision
Migrate the ingestion and dispatch services to containerised applications running on EKS, fronted by an ALB. Authentication moves from Cognito to Azure EntraID (or a lightweight Lambda Authorizer pattern at the ALB level). Deployment is managed via ArgoCD and Helm charts stored in ECR.

## Consequences

**Positive**
- ALB has no meaningful payload size limit for the use case
- Pod autoscaling handles sustained high throughput without concurrency caps
- Eliminates Cognito cost
- JSON and Gzip handled in application code — no infrastructure toggle needed
- Consistent deployment model with other EKS workloads
- PROD downtime target (<2 min) is achievable with rolling deployments or per-endpoint rollout

**Negative**
- Higher baseline infrastructure cost vs. true serverless (pods running even at low traffic)
- Container build, push, and scan pipeline required (Wiz, Checkmarx)
- Team must manage pod sizing — requires performance testing before go-live
- Azure EntraID proxy whitelisting may be required for external auth flows
