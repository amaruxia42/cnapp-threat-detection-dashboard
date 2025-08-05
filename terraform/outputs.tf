#/cnapp_threat_detection_dashboard/terraform/outputs.tf
output "log_bucket_name" {
    value = module.s3.log_bucket_name
}

output "sns_topic_name" {
    value = var.sns_topic_name
}

output "aws_region" {
    value = var.aws_region
}

output "lambda_function_arn" {
    value = module.iam.lambda_role_arn 
}