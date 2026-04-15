# CLINPR-610: App1 – Add health check endpoints (/health and /health/details)

- **Status:** Backlog
- **Assignee:** Unassigned
- **Fix Version:** —

## Acceptance Criteria (Extracted)

- Expose `GET /health` endpoint for lightweight service availability check.
- Expose `GET /health/details` endpoint for detailed health information.
- `GET /health` returns HTTP 200 when the application is up.
- `GET /health/details` returns HTTP 200 with non-sensitive runtime context.
- `/health/details` must not expose secrets or sensitive configuration.
- Both endpoints are available for App1 running on EKS.
- Endpoint behavior and response format are documented.

[← Back to backlog index](../../backlog.md)
