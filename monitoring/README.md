# Monitoring

Dashboards and alert definitions for the Feeds Dispatcher.

| Folder | Platform | Environments |
|--------|----------|-------------|
| [cloudwatch/](cloudwatch/) | AWS CloudWatch | All |
| [splunk/](splunk/) | Splunk | FIS / UAT / TEST / MIG |

## Key Metrics to Watch

| Metric | Source | Alert Threshold |
|--------|--------|----------------|
| SQS queue depth | CloudWatch | > 1000 messages |
| DLQ message count | CloudWatch | > 0 |
| App1 error rate (5xx) | CloudWatch | > 1% over 5 min |
| App2 error rate | CloudWatch | > 1% over 5 min |
| App1 P99 latency | CloudWatch | > 2000ms |
| EventBridge failed invocations | CloudWatch | > 0 |

## Dashboard Export / Import

CloudWatch dashboards are exported as JSON and stored in `cloudwatch/dashboards/`.
Splunk dashboards are exported as XML/JSON and stored in `splunk/dashboards/`.

To apply a CloudWatch dashboard:
```bash
aws cloudwatch put-dashboard \
  --dashboard-name feeds-dispatcher-{env} \
  --dashboard-body file://cloudwatch/dashboards/main.json
```
