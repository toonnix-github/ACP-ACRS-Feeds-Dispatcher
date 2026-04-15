# App1 — Ingestion Service

Receives hotel data feeds from ACRS via the ALB, authenticates, validates, decompresses, stores to S3, and enqueues a lightweight message to SQS.

## Responsibilities

1. Accept HTTP POST on `/feeds/{feedType}`
2. Authenticate the request (Azure EntraID / Lambda Authorizer)
3. Validate payload (content-type, size limits)
4. Decompress if Gzip
5. Write raw payload to S3: `s3://{bucket}/{feedType}/{yyyy}/{mm}/{dd}/{uuid}`
6. Enqueue message to SQS with: `feedType`, `s3Key`, `s3Bucket`, `receivedAt`, `sizeBytes`
7. Return HTTP 200 immediately

## Health Endpoints

| Endpoint | Auth | Purpose |
|----------|------|---------|
| `GET /health` | None (rate limited) | Liveness — returns 200 if service is up |
| `GET /health/details` | Required | Readiness — checks S3 + SQS connectivity |

## Environment Variables

See [.env.example](.env.example) for all required configuration.

## Local Development

```bash
cp .env.example .env
# Fill in required values
docker build -t app1-ingestion .
docker run --env-file .env -p 8080:8080 app1-ingestion
```

## Running Tests

```bash
# From this directory
docker build --target test -t app1-ingestion-test .
docker run app1-ingestion-test
```
