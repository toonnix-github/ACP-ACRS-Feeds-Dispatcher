# Consumer Onboarding

## Who Is This For?
Teams that want to receive feed events from the Feeds Dispatcher (e.g., Loyalty, Data Team, FastCom, or a new consumer).

## Step 1 — Request Access

Contact the Feeds Dispatcher team and provide:
- Your team name
- Which feed(s) you want to consume
- Your AWS account ID (for EventBridge cross-account allowlisting)
- Your EventBridge event bus ARN (or request a new one to be created)

## Step 2 — Provision Your Consumer Infrastructure

Use the consumer Terraform module in this repo:

```hcl
module "my_consumer" {
  source = "../../infra/terraform/modules/consumer"

  consumer_name    = "my-team"
  feed_types       = ["acrs-hotel-rates", "acrs-hotel-content"]
  event_bus_arn    = "arn:aws:events:eu-west-1:123456789:event-bus/my-team-feeds"
  environment      = "dev"
}
```

The module provisions:
- EventBridge rule (filter by feed type)
- DLQ for failed event delivery
- CloudWatch log group
- IAM permissions

## Step 3 — Implement Your Event Handler

Your handler will receive an event with this structure:

```json
{
  "source": "feeds-dispatcher",
  "detail-type": "FeedDelivered",
  "detail": {
    "feedType": "acrs-hotel-rates",
    "s3Bucket": "feeds-dispatcher-raw-{env}",
    "s3Key": "acrs-hotel-rates/2026/04/15/abc123.json.gz",
    "presignedUrl": "https://...",
    "presignedUrlExpiresAt": "2026-04-15T16:00:00Z",
    "contentType": "application/gzip",
    "sizeBytes": 4200000,
    "receivedAt": "2026-04-15T13:00:00Z"
  }
}
```

Fetch the payload using the `presignedUrl`. The URL expires — process promptly or download and store locally.

## Step 4 — Test in DEV / OAT

1. Deploy your consumer in DEV
2. Trigger a test feed via the publisher endpoint
3. Confirm your handler receives the event and can fetch the payload
4. Validate in OAT before requesting PROD allowlisting

## Step 5 — PROD Allowlisting

Provide your PROD EventBridge ARN to the Feeds Dispatcher team. They will add it via Terraform and deploy to PROD.

---

## Important Notes

- **Idempotency**: SQS delivers at-least-once. Your handler should be idempotent — the same event may arrive more than once.
- **Presigned URL TTL**: URLs expire after a configured period (typically 24h). Do not cache URLs.
- **DLQ monitoring**: Monitor your consumer DLQ. Failed events do not retry indefinitely.
