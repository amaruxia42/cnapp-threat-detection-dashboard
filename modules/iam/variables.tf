# /cnapp_threat_detection_dashboard/modules/iam/variables.tf
variable "aws_region" {
  description = "AWS region of deployment"
  type        = string
}

variable "log_bucket_name" {
  description = "S3 bucket for archiving logs"
  type        = string
}

variable "lambda_role_name" {
  description = "Lambda function role name"
  type = object({
    name = string
  })
}

variable "tags" {
  description = "Tags to apply to GuardDuty resources"
  type        = map(string)
  default     = {}
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "sns_topic_name" {
  description = "Name of SNS topic"
  type = string
}