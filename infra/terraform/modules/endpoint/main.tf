locals {
  name_prefix = "feeds-dispatcher-endpoint-${var.feed_type}-${var.environment}"
}

# --- ALB Listener Rule ---
resource "aws_lb_listener_rule" "feed_endpoint" {
  listener_arn = var.alb_listener_arn

  action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }

  condition {
    path_pattern {
      values = [var.path]
    }
  }

  tags = {
    FeedType    = var.feed_type
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

# --- S3 Prefix (logical convention, no resource needed) ---
# Feed payloads are stored under s3://{bucket}/{feed_type}/
# The S3 bucket itself is managed at the environment level, not per-endpoint.

# --- CloudWatch Log Group for this feed type ---
resource "aws_cloudwatch_log_group" "feed_endpoint" {
  name              = "/feeds-dispatcher/endpoints/${var.feed_type}/${var.environment}"
  retention_in_days = 30

  tags = {
    FeedType    = var.feed_type
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
