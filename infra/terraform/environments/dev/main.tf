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
    key            = "dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "feeds-dispatcher-tflock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

# --- Consumers ---
module "loyalty_consumer" {
  source        = "../../modules/consumer"
  consumer_name = "loyalty"
  feed_types    = ["acrs-hotel-rates", "acrs-hotel-content"]
  event_bus_arn = var.loyalty_event_bus_arn
  environment   = "dev"
}

module "data_team_consumer" {
  source        = "../../modules/consumer"
  consumer_name = "data-team"
  feed_types    = ["acrs-hotel-rates", "acrs-hotel-content", "acrs-hotel-availability"]
  event_bus_arn = var.data_team_event_bus_arn
  environment   = "dev"
}

module "fastcom_consumer" {
  source        = "../../modules/consumer"
  consumer_name = "fastcom"
  feed_types    = ["acrs-hotel-content"]
  event_bus_arn = var.fastcom_event_bus_arn
  environment   = "dev"
}

# --- Endpoints ---
module "hotel_rates_endpoint" {
  source           = "../../modules/endpoint"
  feed_type        = "acrs-hotel-rates"
  path             = "/feeds/acrs-hotel-rates"
  environment      = "dev"
  alb_listener_arn = var.alb_listener_arn
  target_group_arn = var.app1_target_group_arn
}
