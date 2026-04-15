# Business

Business-facing documentation for the Feeds Dispatcher. Audience: Product, Leadership, Architects.

## Contents

| File | Description |
|------|-------------|
| [product-brief.md](product-brief.md) | What this product is, why it exists, who owns it |

## Why This Product Exists

ACRS (Amadeus) produces hotel data feeds that must reach multiple internal consumers reliably. Without the Feeds Dispatcher, each consumer would need a direct integration with ACRS — creating tight coupling, duplicated auth logic, and no resilience.

The Feeds Dispatcher is the single reliable bridge between one producer and many consumers.
