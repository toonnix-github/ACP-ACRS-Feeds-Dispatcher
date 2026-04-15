# App1 – Implement GET /health endpoint

- **Status:** Backlog
- **Assignee:** Unassigned
- **Fix Version:** —
- **Jira Ticket:** _TBD_

## User Story

As a platform/application operator, I want the Feeds Dispatcher App1 service to expose a lightweight `GET /health` endpoint, so that the platform (ALB, Kubernetes liveness/readiness probes) can validate that the service is running and available.

## Acceptance Criteria (Extracted)

- Expose `GET /health` endpoint on App1 ingestion service.
- Returns HTTP 200 with `{ "status": "ok" }` when the application is up and accepting requests.
- Returns HTTP 503 when the application is not ready to serve traffic.
- Endpoint must be **unauthenticated** — no token or API key required.
- Endpoint must be **rate-limited** to prevent abuse.
- Response time must be < 50 ms (no downstream dependency checks).
- Endpoint is compatible with Kubernetes liveness and readiness probe configuration.
- Endpoint is accessible when App1 is deployed on EKS behind the ALB.

## Notes

- This is the public-facing health check. It must not expose any internal details, configuration, or secrets.
- See also: [/health/details ticket](health-details-endpoint.md) for the detailed health endpoint.
- Reference: [Health Check Endpoints Issue](../../../issues/health-check-endpoints.md)

[← Back to backlog index](../../backlog.md)
