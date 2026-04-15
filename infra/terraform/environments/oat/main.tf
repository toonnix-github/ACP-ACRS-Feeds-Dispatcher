terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "feeds-dispatcher-tfstate"
    key            = "oat/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "feeds-dispatcher-tflock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# OAT aggregates UAT / TEST / MIG / PDT namespaces.
# Add modules mirroring dev/main.tf with oat-specific ARNs.
