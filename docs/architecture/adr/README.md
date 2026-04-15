# Architecture Decision Records (ADRs)

ADRs capture significant design decisions — the context, the options considered, and the rationale for the choice made. They are **permanent records**: once accepted, an ADR is never edited or deleted. If a decision is reversed, a new ADR supersedes it.

## Index

| ADR | Title | Status |
|-----|-------|--------|
| [0001](0001-payload-strategy.md) | Large Payload Strategy — Store in S3, reference by URL | Accepted |
| [0002](0002-eks-over-serverless.md) | Move from Serverless to EKS | Accepted |
| [0003](0003-sqs-decoupling.md) | SQS as Decoupling Layer between Ingestion and Dispatch | Accepted |

## Format

```
# ADR-NNNN: Title

## Status
Proposed | Accepted | Deprecated | Superseded by ADR-XXXX

## Context
What problem were we solving? What constraints existed?

## Decision
What did we decide?

## Consequences
What are the trade-offs? What becomes easier? What becomes harder?
```

## Adding a New ADR

1. Copy the format above
2. Number it sequentially (`0004-...`)
3. Set status to `Proposed`
4. Open a PR — ADR is accepted when the PR is merged
