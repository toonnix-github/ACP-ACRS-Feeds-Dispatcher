# Compliance

## ACP Label Framework

The Feeds Dispatcher must comply with the ACP Label Framework across three domains.

| Domain | Status | Notes |
|--------|--------|-------|
| Security | In Progress (~70%) | Auth, secrets management, network policies |
| Operational | In Progress | Runbooks, alerting, DR procedure |
| Architecture | In Progress | ADRs filed, EKS migration pending |

## Health Endpoints

| Endpoint | Access | Purpose |
|----------|--------|---------|
| `GET /health` | Public (rate limited) | Liveness probe, load balancer health check |
| `GET /health/details` | Authenticated | Readiness probe, dependency status |

## Security Controls

- All traffic via HTTPS (TLS at ALB)
- Azure EntraID authentication for feed publishers
- Secrets stored in AWS Secrets Manager (no plaintext credentials in code or config)
- Container images scanned on every build (Wiz + Checkmarx)
- Network policies restrict pod-to-pod communication in EKS

## Open Items

- [ ] Complete ACP Label Framework (target: next PI)
- [ ] Document DR procedure for SQS + S3 failure scenarios
- [ ] Confirm Azure EntraID proxy whitelist requirements
- [ ] Review S3 bucket policies for least-privilege access
