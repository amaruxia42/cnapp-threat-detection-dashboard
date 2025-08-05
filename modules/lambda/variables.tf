# cnapp_threat_detection_dashboard/modules/lambda/variables.tf
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_role_arn" {
  description = "IAM Role ARN for the Lambda function"
  type        = string
}

variable "lambda_handler" {
  description = "Lambda function handler (e.g. index.handler)"
  type        = string
  default     = "index.handler"
}

variable "lambda_runtime" {
  description = "Lambda runtime environment"
  type        = string
  default     = "python3.13"
}

variable "lambda_package_path" {
  description = "Path to the Lambda deployment package ZIP file"
  type        = string
}

variable "timeout" {
  description = "Function execution timeout in seconds"
  type        = number
  default     = 10
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda function can use"
  type        = number
  default     = 128
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to the Lambda function"
  type        = map(string)
  default     = {}
}