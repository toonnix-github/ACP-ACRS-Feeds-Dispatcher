output "dlq_arn" {
  description = "ARN of the consumer DLQ"
  value       = aws_sqs_queue.dlq.arn
}

output "dlq_url" {
  description = "URL of the consumer DLQ"
  value       = aws_sqs_queue.dlq.id
}

output "log_group_name" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.consumer.name
}
