# Terraform

## Structure

```
terraform/
├── modules/
│   ├── consumer/    # Provisions EventBridge rule, DLQ, IAM, CW logs for a consumer
│   └── endpoint/    # Provisions ALB rule, auth, S3 prefix for a feed endpoint
└── environments/
    ├── dev/
    ├── oat/
    └── prod/
```

## Usage

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

## Remote State

State is stored in S3 with DynamoDB locking. Configure your backend in each environment's `main.tf`:

```hcl
terraform {
  backend "s3" {
    bucket         = "feeds-dispatcher-tfstate"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "feeds-dispatcher-tflock"
    encrypt        = true
  }
}
```

## Adding a New Consumer

```hcl
module "loyalty_consumer" {
  source        = "../../modules/consumer"
  consumer_name = "loyalty"
  feed_types    = ["acrs-hotel-rates"]
  event_bus_arn = "arn:aws:events:eu-west-1:123456789:event-bus/loyalty-feeds"
  environment   = "dev"
}
```

## Adding a New Endpoint

```hcl
module "hotel_rates_endpoint" {
  source      = "../../modules/endpoint"
  feed_type   = "acrs-hotel-rates"
  path        = "/feeds/acrs-hotel-rates"
  environment = "dev"
}
```
