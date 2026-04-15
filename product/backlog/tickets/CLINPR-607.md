# CLINPR-607: [AFD][DEV] S3 Object Key Collision Fix

- **Status:** Done
- **Assignee:** Zakriya ALI SABIR
- **Fix Version:** PI7

## Acceptance Criteria (Extracted)

- Append `request_id` to S3 object key to avoid collisions on same `ama-correlation-id`.
- S3 key change: `${version}_${detailType}/${hash}/${year}/${month}/${day}/${correlationID}.(gz|json)` -> `${version}_${detailType}/${hash}/${year}/${month}/${day}/${correlationID}_${requestId}.(gz|json)`
- Maintain backward compatibility and validate downstream parsing.
- Ensure unit tests are successful in upload-orchestrator and async-processor.
- Attach S3 UI snapshots after final terraform deployment validation.

[← Back to backlog index](../../backlog.md)
