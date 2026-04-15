# Splunk

Splunk dashboards for the Feeds Dispatcher. Used for FIS / UAT / TEST / MIG environments.

## Dashboards

Stored in `dashboards/` as exported Splunk XML/JSON.

| Dashboard | Purpose |
|-----------|---------|
| `feeds-ingestion-overview` | Ingestion rate, payload sizes, feed type breakdown |
| `feeds-dispatch-overview` | Dispatch latency, EventBridge delivery success rate |
| `feeds-dlq-investigation` | DLQ message timeline, feed types, error codes |
| `feeds-consumer-health` | Per-consumer delivery success, DLQ depth |

## Importing a Dashboard

1. Go to Splunk → Dashboards → Import
2. Select the XML file from `dashboards/`
3. Update the index and sourcetype to match the target environment

## Log Sources

| Source | Splunk Index | Sourcetype |
|--------|-------------|------------|
| App1 (Ingestion) | `feeds_dispatcher` | `app1_ingestion` |
| App2 (Dispatch) | `feeds_dispatcher` | `app2_dispatch` |
| ALB access logs | `feeds_dispatcher_alb` | `aws:alb` |
