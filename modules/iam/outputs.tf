# /cnapp_threat_detection_dashboard/modules/iam/outputs.tf
output "lambda_role_name" {
  value = aws_iam_role.lambda_cnapp_role.name
}

output "lambda_policy_arn" {
  value = aws_iam_policy.lambda_cnapp_policy.arn
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_cnapp_role.arn
}