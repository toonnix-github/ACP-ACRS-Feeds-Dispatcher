# Publisher Onboarding

## Who Is This For?
Teams that want to send a new feed type to the Feeds Dispatcher (e.g., a new ACRS data type, a new upstream system).

## Step 1 — Raise a ServiceNow Request

Submit a request with the following information:

| Field | Description | Example |
|-------|-------------|---------|
| Canonical feed name | Unique identifier for this feed | `acrs-hotel-rates` |
| Action | `create` / `update` / `delete` | `create` |
| Description | What data does this feed contain? | "Daily hotel rate updates from ACRS" |
| Expected payload size | Typical and maximum payload size | `~2 MB typical, ~8 MB max` |
| Expected frequency | How often feeds are sent | `Every 15 minutes` |
| Format | Payload format | `JSON` or `Gzip` |
| Contact team | Who to contact for issues | `team-acrs@company.com` |

## Step 2 — Endpoint Provisioning

The Feeds Dispatcher team will:
1. Create a new ALB path rule (e.g., `/feeds/acrs-hotel-rates`)
2. Provision auth credentials via the `endpoint` Terraform module (`infra/terraform/modules/endpoint/`)
3. Deploy to DEV → OAT → PROD via ArgoCD

You will receive:
- Endpoint URL
- Auth credentials (via secrets manager)

## Step 3 — Integration Testing

Test against the **DEV** environment first:
- Send a sample payload to the endpoint
- Confirm HTTP 200 response
- Verify the payload appears in the S3 bucket (Dev)
- Confirm an SQS message was enqueued

## Step 4 — OAT Validation

Repeat the above in OAT. At least one successful end-to-end delivery to a consumer is required before PROD promotion.

## Step 5 — PROD

Coordinate PROD cutover with the Feeds Dispatcher team. ACRS retry window is **2 minutes** — plan accordingly.

---

## Feed Identification

Feeds are identified by their **ALB path** (e.g., `/feeds/acrs-hotel-rates`). The path must be:
- Lowercase, hyphenated
- Prefixed with `/feeds/`
- Unique across all environments
