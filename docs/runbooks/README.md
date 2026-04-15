# Runbooks

Operational guides for on-call engineers. When something goes wrong, start here.

## Quick Reference

| Symptom | Runbook |
|---------|---------|
| Messages accumulating in DLQ | [DLQ Investigation](dlq-investigation.md) |
| Deploying to PROD | [Deployment Checklist](deployment-checklist.md) |

## General Principles

- **Check CloudWatch first** — dashboard shows SQS queue depth, DLQ count, App1/App2 error rate
- **Never delete DLQ messages** without first understanding why they failed
- **PROD downtime window is 2 minutes** — ACRS will retry, but exceeding 2 min risks feed loss
- **All changes via ArgoCD** — do not apply Terraform or kubectl changes manually in PROD without approval

## Escalation

| Severity | Action |
|----------|--------|
| DLQ growing, feeds delayed | Investigate + notify team channel |
| App1 or App2 down | Page on-call, escalate to platform team |
| PROD data loss suspected | Incident bridge immediately |
