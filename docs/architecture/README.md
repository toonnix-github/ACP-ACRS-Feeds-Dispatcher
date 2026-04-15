# Architecture

## Overview

The Feeds Dispatcher moves through two major generations:

| Version | Stack | Status |
|---------|-------|--------|
| v1/v2 | Serverless — API GW + Lambda + EventBridge | Current (legacy) |
| v4 | EKS — ALB + App1 + S3 + SQS + App2 + EventBridge | Target |

See [overview.md](overview.md) for the full architecture narrative and diagrams.

## Architecture Decision Records (ADRs)

Significant decisions are recorded in [adr/](adr/). Read the ADR index before proposing changes to the core design.

## Diagrams

Source files for standalone diagrams live in [diagrams/](diagrams/). Mermaid diagrams embedded directly in Markdown are preferred — store `.mermaid` source here only when the diagram is too complex to inline.
