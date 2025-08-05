#/cnapp_threat_detection_dashboard/modules/security_hub/outputs.tf
output "securityhub_enabled" {
  description = "Indicates if Security Hub is enabled"
  value       = true
}

output "sec_hub_subscription" {
  value = aws_securityhub_standards_subscription.cis
  
}
