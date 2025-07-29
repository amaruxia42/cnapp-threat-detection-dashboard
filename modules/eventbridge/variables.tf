# /cnapp_threat_detection_dashboard/terraform/eventbridge/variables.tf
variable "rule_name" {
  description = "Name of the EventBridge rule"
  type        = string
}

variable "description" {
  description = "Description of the EventBridge rule"
  type        = string
  default     = "Triggers on new GuardDuty findings"
}

variable "lambda_function_arn" {
  description = "ARN of the Lambda function to invoke"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to invoke"
  type        = string
}

variable "tags" {
  description = "Tags to apply to EventBridge rule"
  type        = map(string)
  default     = {}
}