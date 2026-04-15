# Onboarding

Guides for connecting to the Feeds Dispatcher — either as a **publisher** (sending feeds) or a **consumer** (receiving events).

## I want to...

| Goal | Guide |
|------|-------|
| Send a new feed type to the dispatcher | [Publisher Onboarding](publisher-onboarding.md) |
| Receive feed events in my system | [Consumer Onboarding](consumer-onboarding.md) |

## How Onboarding Works

All onboarding is infrastructure-driven — there is no manual configuration. Everything is provisioned via Terraform and deployed via ArgoCD.

1. Publisher raises a ServiceNow request
2. Team creates a new endpoint via Terraform (`infra/terraform/modules/endpoint/`)
3. Consumer sets up their EventBridge via Terraform (`infra/terraform/modules/consumer/`)
4. Both sides are tested in OAT before PROD promotion
