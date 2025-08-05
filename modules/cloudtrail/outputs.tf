#/cnapp_threat_detection_dashboard/terraform/outputs.tf
output "cloudtrail_arn" {
  description = "ARN of the CloudTrail trail"
  value       = aws_cloudtrail.cloudtrail_cnapp.arn
}

output "cloudtail_id" {
  description = "ID of CloudTrail trail"
  value       = aws_cloudtrail.cloudtrail_cnapp.id
}