# CLINPR-605: [AFD][OAT::TEST] Rollout the gzip/json support of upload and async lambda functions

- **Status:** Validation
- **Assignee:** Zakriya ALI SABIR
- **Fix Version:** PI7

## Acceptance Criteria (Extracted)

- Update upload lambda from `upload-orchestrator-0.0.2-RC.5` to `upload-orchestrator-0.0.2-RC.6`.
- Update async lambda from `async-processor-0.0.2-RC.11` to `async-processor-0.0.2-RC.12`.
- Update all API endpoints to use upload lambda function as `aws_proxy`.
- Enable `_raw.json` trigger on S3.
- Add support for feature toggle `should_enable_s3_bucket_versioning`.

[← Back to backlog index](../../backlog.md)
