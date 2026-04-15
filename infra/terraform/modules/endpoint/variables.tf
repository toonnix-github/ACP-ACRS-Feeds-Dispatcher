variable "feed_type" {
  description = "Canonical feed type name (e.g. acrs-hotel-rates)"
  type        = string
}

variable "path" {
  description = "ALB path for this feed (e.g. /feeds/acrs-hotel-rates)"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, oat, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "oat", "prod"], var.environment)
    error_message = "environment must be one of: dev, oat, prod"
  }
}

variable "alb_listener_arn" {
  description = "ARN of the ALB listener to attach the path rule to"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the App1 target group"
  type        = string
}
