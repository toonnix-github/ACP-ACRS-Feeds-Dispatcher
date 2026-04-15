# ADR-0003: SQS as Decoupling Layer Between Ingestion and Dispatch

## Status
Accepted

## Context
In the v1/v2 architecture, Lambda handled both ingestion and dispatch synchronously. This meant a downstream failure (e.g., EventBridge unavailable, consumer DLQ full) could cause the entire feed ingestion to fail, forcing ACRS to retry.

ACRS has a 2-minute retry window. If the dispatcher is unavailable or slow, feeds are lost or duplicated. The system needs to accept the payload quickly and process it asynchronously.

## Decision
App1 (Ingestion) and App2 (Dispatch) are decoupled by an SQS queue. App1 writes to S3 and enqueues a lightweight message to SQS, then returns HTTP 200 to ACRS immediately. App2 polls SQS independently and handles transformation and publishing. A DLQ catches messages that fail processing after the configured retry count.

Message ordering is not required — the system is designed to tolerate out-of-order delivery and duplicates.

## Consequences

**Positive**
- App1 can acknowledge ACRS quickly (<2 min SLA) regardless of downstream state
- App2 failures do not affect ingestion throughput
- SQS retry + DLQ provides resilience without custom retry logic
- Independent scaling of ingestion and dispatch pods
- DLQ enables investigation and replay of failed messages without data loss

**Negative**
- End-to-end latency increases (async by design)
- Duplicate message delivery is possible (SQS at-least-once) — consumers must be idempotent
- Deduplication not yet implemented — planned for a future iteration
- Adds operational surface: SQS queue depth and DLQ must be monitored
