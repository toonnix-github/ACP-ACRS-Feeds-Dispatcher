# App1 – Implement GET /health/details endpoint

- **Status:** Backlog
- **Assignee:** Unassigned
- **Fix Version:** —
- **Jira Ticket:** _TBD_

## User Story

As a platform/application operator, I want the Feeds Dispatcher App1 service to expose a `GET /health/details` endpoint that returns runtime context and dependency status, so that I can investigate issues, validate configuration, and monitor service health in detail.

## Acceptance Criteria (Extracted)

- Expose `GET /health/details` endpoint on App1 ingestion service.
- Returns HTTP 200 with a JSON body containing non-sensitive runtime context, including at minimum:
  - Application version / commit SHA
  - Uptime
  - Node.js version
  - Environment name (e.g. `dev`, `oat`, `prod`)
  - Downstream dependency status (S3 reachability, SQS reachability)
  - Timestamp of the response
- Returns HTTP 503 if any critical downstream dependency is unreachable.
- Endpoint must be **authenticated** — requires a valid token or API key.
- Must **not** expose secrets, credentials, access keys, or sensitive configuration values.
- Response format is documented (schema included in endpoint documentation).
- Endpoint is accessible when App1 is deployed on EKS behind the ALB.

## Notes

- This is the detailed, authenticated health check intended for operational investigation and monitoring dashboards.
- Dependency checks (S3, SQS) should have a timeout (e.g. 3 seconds) to avoid blocking the response.
- See also: [/health ticket](health-endpoint.md) for the lightweight public health endpoint.
- Reference: [Health Check Endpoints Issue](../../../issues/health-check-endpoints.md)

[← Back to backlog index](../../backlog.md)
