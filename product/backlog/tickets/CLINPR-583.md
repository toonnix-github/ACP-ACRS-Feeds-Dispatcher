# CLINPR-583: App1 – Ingestion Service

- **Status:** Backlog
- **Assignee:** Zakriya ALI SABIR
- **Fix Version:** —

## Acceptance Criteria (Extracted)

- Develop App1 ingestion service on EKS behind ALB.
- Handle `application/gzip` + `content-encoding=gzip` as compressed payload.
- Handle `application/json` as validated JSON payload.
- Validate authentication and CRC where applicable.
- Reject invalid JSON with HTTP 400.
- Store file in S3 and send message to SQS.
- Return appropriate response status to requester.

[← Back to backlog index](../../backlog.md)
