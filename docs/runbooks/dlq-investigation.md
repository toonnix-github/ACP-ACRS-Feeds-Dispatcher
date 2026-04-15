# Runbook: DLQ Investigation

## Trigger
- CloudWatch alarm: DLQ message count > 0
- Splunk alert: DLQ depth rising

## Step 1 — Identify Which DLQ

There are two DLQs:

| DLQ | Source | What it means |
|-----|--------|---------------|
| `feeds-dispatcher-sqs-dlq-{env}` | SQS → App2 failed | App2 could not process a message |
| Consumer DLQ (per consumer) | EventBridge delivery failed | Consumer's handler failed or is unreachable |

Check CloudWatch to confirm which DLQ has messages.

## Step 2 — Inspect the Failed Message

```bash
# Read a message from the DLQ (does not delete it)
aws sqs receive-message \
  --queue-url https://sqs.eu-west-1.amazonaws.com/{account}/feeds-dispatcher-sqs-dlq-{env} \
  --attribute-names All \
  --message-attribute-names All
```

Look for:
- `feedType` — which feed type failed?
- `s3Key` — is the S3 object still there?
- `approximateReceiveCount` — how many times was it retried?
- Error details in the message body

## Step 3 — Diagnose the Root Cause

| Symptom | Likely Cause |
|---------|-------------|
| S3 key not found | App1 wrote to wrong bucket/key; S3 lifecycle deleted it |
| EventBridge publish failed | Consumer ARN invalid or permissions changed |
| App2 crash loop | Application bug — check App2 pod logs |
| Presigned URL generation failed | IAM role missing S3 permission |

```bash
# Check App2 pod logs
kubectl logs -n feeds-dispatcher -l app=app2-dispatch --tail=100
```

## Step 4 — Remediate

### Option A: Replay the message
If the root cause is fixed, move the message back to the main queue:

```bash
aws sqs send-message \
  --queue-url https://sqs.eu-west-1.amazonaws.com/{account}/feeds-dispatcher-sqs-{env} \
  --message-body '{...original message body...}'

# Then delete from DLQ
aws sqs delete-message \
  --queue-url https://sqs.eu-west-1.amazonaws.com/{account}/feeds-dispatcher-sqs-dlq-{env} \
  --receipt-handle {receipt-handle}
```

### Option B: Discard the message
If the feed is stale or the publisher will resend, delete after documenting the reason.

## Step 5 — Document

Add a note to the incident channel with:
- Which DLQ / how many messages
- Root cause
- Action taken
- Whether feeds were lost or replayed
