## User Story
As a platform/application operator, I want the Feeds Dispatcher app running on EKS to expose health check endpoints for `/health` and `/health/details`, so that the platform can validate service availability and provide runtime context for monitoring and troubleshooting.

## Background
The application will be deployed on EKS and should provide standard health check endpoints to support platform operations, observability, and troubleshooting.

Expected endpoints:
- `/health`
- `/health/details`

High-level expectation:
- `/health` is a lightweight endpoint for service availability check
- `/health/details` returns additional context/details useful for investigation and operational validation

## Acceptance Criteria
- Application exposes `GET /health`
- Application exposes `GET /health/details`
- `/health` returns HTTP 200 when the application is up
- `/health/details` returns HTTP 200 with contextual information
- Both endpoints are accessible in EKS environment
- Response format is documented
- No sensitive data exposed in `/health/details`
