# App2 — Dispatch Service

Polls SQS for messages enqueued by App1, generates S3 presigned URLs for the raw payload, and publishes a `FeedDelivered` event to EventBridge for downstream consumers.

## Responsibilities

1. Poll SQS queue for new messages
2. Retrieve S3 object metadata for the referenced payload
3. Generate a presigned URL (TTL configurable)
4. Publish `FeedDelivered` event to EventBridge with the presigned URL and metadata
5. Delete the SQS message on successful publish
6. On failure: do not delete — SQS will retry; message moves to DLQ after max retries

## Event Schema (published to EventBridge)

```json
{
  "source": "feeds-dispatcher",
  "detail-type": "FeedDelivered",
  "detail": {
    "feedType": "acrs-hotel-rates",
    "s3Bucket": "feeds-dispatcher-raw-dev",
    "s3Key": "acrs-hotel-rates/2026/04/15/abc123.json.gz",
    "presignedUrl": "https://...",
    "presignedUrlExpiresAt": "2026-04-15T16:00:00Z",
    "contentType": "application/gzip",
    "sizeBytes": 4200000,
    "receivedAt": "2026-04-15T13:00:00Z"
  }
}
```

## Health Endpoints

| Endpoint | Auth | Purpose |
|----------|------|---------|
| `GET /health` | None (rate limited) | Liveness |
| `GET /health/details` | Required | Readiness — checks SQS + EventBridge + S3 connectivity |

## Environment Variables

See [.env.example](.env.example) for all required configuration.

## Local Development

```bash
cp .env.example .env
docker build -t app2-dispatch .
docker run --env-file .env app2-dispatch
```
