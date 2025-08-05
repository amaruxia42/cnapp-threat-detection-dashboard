#/cnapp_threat_detection_dashboard/modules/sns_alerts/outputs.tf
output "sns_topic_arn" {
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.cnapp_alerts.arn
}