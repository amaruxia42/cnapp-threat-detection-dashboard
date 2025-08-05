# /cnapp_threat_detection_dashboard/modules/lambda/outputs.tf
output "lambda_function_name" {
  description = "Name of Lambda function"
  value       = aws_lambda_function.cnapp_func.function_name
}

output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.cnapp_func.arn
}