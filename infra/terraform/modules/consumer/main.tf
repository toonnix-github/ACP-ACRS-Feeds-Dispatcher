locals {
  name_prefix = "feeds-dispatcher-consumer-${var.consumer_name}-${var.environment}"
}

# --- DLQ ---
resource "aws_sqs_queue" "dlq" {
  name                      = "${local.name_prefix}-dlq"
  message_retention_seconds = var.dlq_message_retention_seconds

  tags = {
    Environment = var.environment
    Consumer    = var.consumer_name
    ManagedBy   = "terraform"
  }
}

# --- CloudWatch Log Group ---
resource "aws_cloudwatch_log_group" "consumer" {
  name              = "/feeds-dispatcher/consumers/${var.consumer_name}/${var.environment}"
  retention_in_days = 30

  tags = {
    Environment = var.environment
    Consumer    = var.consumer_name
    ManagedBy   = "terraform"
  }
}

# --- EventBridge Rule (one per feed type) ---
resource "aws_cloudwatch_event_rule" "feed_rule" {
  for_each = toset(var.feed_types)

  name           = "${local.name_prefix}-${each.value}"
  description    = "Route ${each.value} feeds to ${var.consumer_name}"
  event_bus_name = "feeds-dispatcher-${var.environment}"

  event_pattern = jsonencode({
    source      = ["feeds-dispatcher"]
    detail-type = ["FeedDelivered"]
    detail = {
      feedType = [each.value]
    }
  })

  tags = {
    Environment = var.environment
    Consumer    = var.consumer_name
    FeedType    = each.value
    ManagedBy   = "terraform"
  }
}

# --- EventBridge Target ---
resource "aws_cloudwatch_event_target" "consumer_bus" {
  for_each = toset(var.feed_types)

  rule           = aws_cloudwatch_event_rule.feed_rule[each.value].name
  event_bus_name = "feeds-dispatcher-${var.environment}"
  target_id      = "${var.consumer_name}-${each.value}"
  arn            = var.event_bus_arn

  dead_letter_config {
    arn = aws_sqs_queue.dlq.arn
  }
}
