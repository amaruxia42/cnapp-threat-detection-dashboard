# /cnapp_threat_detection/modules/eventbridge/outputs.tf
output "event_rule_arn" {
  description = "ARN of the CloudWatch EventBridge rule"
  value       = aws_cloudwatch_event_rule.guarduty_findings.arn
}

output "event_rule_name" {
  description = "Name of CloudWatch EventBridge Rule"
  value       = aws_cloudwatch_event_rule.guarduty_findings.name
}

