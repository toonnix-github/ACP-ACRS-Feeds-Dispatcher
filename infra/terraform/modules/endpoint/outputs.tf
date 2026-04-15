output "listener_rule_arn" {
  description = "ARN of the ALB listener rule for this endpoint"
  value       = aws_lb_listener_rule.feed_endpoint.arn
}

output "log_group_name" {
  description = "CloudWatch log group name for this feed type"
  value       = aws_cloudwatch_log_group.feed_endpoint.name
}

output "s3_prefix" {
  description = "S3 key prefix where payloads for this feed type are stored"
  value       = var.feed_type
}
