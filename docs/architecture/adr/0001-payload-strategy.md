# ADR-0001: Large Payload Strategy — Store in S3, Reference by URL

## Status
Accepted

## Context
ACRS feeds frequently exceed 4 MB and can reach 10+ MB. The original architecture used API Gateway, which has a hard 6 MB payload limit. A temporary workaround (accepting compressed Gzip payloads) reduced size but did not solve the underlying problem. EventBridge also has a 256 KB event payload limit, meaning large payloads cannot be embedded in events regardless of how the ingestion layer handles them.

Downstream consumers need access to the full payload, not a truncated version.

## Decision
Raw payloads are stored in S3 at ingestion time. Downstream components (App2, consumers) receive a reference — an S3 presigned URL — rather than the payload itself. No component in the pipeline embeds the full payload in a message or event.

## Consequences

**Positive**
- No effective payload size limit in the pipeline
- S3 acts as a durable source of truth — payloads can be replayed if downstream processing fails
- Consumers can fetch at their own pace; no timeout pressure on the event bus
- Aligned with AWS well-architected best practices for large message handling

**Negative**
- Consumers must implement S3 fetch logic (HTTP GET to presigned URL)
- Presigned URLs expire — TTL must be set long enough for all consumers to process but not indefinitely
- Adds S3 storage cost (mitigated by lifecycle policies)
- Debugging requires correlating S3 keys with SQS message IDs and EventBridge events
