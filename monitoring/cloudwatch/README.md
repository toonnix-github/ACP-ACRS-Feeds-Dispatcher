# CloudWatch

## Dashboards

Stored in `dashboards/` as JSON. One dashboard per environment.

Covers:
- ALB request count, error rate, latency
- App1 pod CPU/memory, request rate, 5xx errors
- App2 pod CPU/memory, SQS processing rate
- SQS queue depth (main queue + DLQ)
- EventBridge invocation success/failure per consumer
- S3 put/get counts

## Alarms

Stored in `alarms/` as Terraform or CloudFormation.

| Alarm | Condition | Action |
|-------|-----------|--------|
| DLQ not empty | DLQ ApproximateNumberOfMessagesVisible > 0 | SNS → PagerDuty |
| App1 high error rate | 5xx > 1% over 5 min | SNS → team channel |
| App2 high error rate | Error rate > 1% over 5 min | SNS → team channel |
| SQS depth high | Queue depth > 1000 | SNS → team channel |
