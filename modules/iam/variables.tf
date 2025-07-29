# /cnapp_threat_detection_dashboard/modules/iam/variables.tf
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