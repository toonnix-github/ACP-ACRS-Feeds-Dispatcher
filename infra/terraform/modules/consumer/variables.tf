variable "consumer_name" {
  description = "Unique name for the consumer (e.g. loyalty, data-team, fastcom)"
  type        = string
}

variable "feed_types" {
  description = "List of feed types this consumer should receive"
  type        = list(string)
}

variable "event_bus_arn" {
  description = "ARN of the consumer's EventBridge event bus"
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

variable "dlq_message_retention_seconds" {
  description = "How long to retain messages in the DLQ (default 14 days)"
  type        = number
  default     = 1209600
}
