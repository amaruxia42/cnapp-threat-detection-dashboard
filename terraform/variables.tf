variable "aws_region" {
  description = "AWS region for deployment"
  type = string
}

variable "cloudtrail_name" {
  description = "Name of CloudTrail"
  type        = string
}

variable "tags" {
  description = "Enviroment name descriptions"
  type        = map(string)
}

variable "guardduty_event_rules" {
  description = "GuardDuty event rules name"
  type        = string
}

variable "eventbridge_desc" {
  description = "Eventbridge description"
  type        = string
}

variable "lambda_function_name" {
  description = "Lambda function name"
  type        = string
}

variable "lambda_handler" {
  description = "Lambda threat detection"
  type        = string
}
variable "lambda_runtime" {
  description = "Programming language runtime version"
  type        = string
}

variable "log_bucket_name" {
  description = "S3 bucket for archiving threat detection logs"
  type        = string
}

variable "lambda_role_name" {
  description = "Lambda role name"
  type = object({
    name = string
  })
}

variable "sns_topic_name" {
  description = "SNS topic name"
  type        = string
}

      