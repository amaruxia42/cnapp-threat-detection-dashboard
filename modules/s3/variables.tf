#/cnapp_threat_detection_dashboard/terraform/variables.tf
variable "log_bucket_name" {
  description = "Name of S3 log bucket"
  type        = string
}

variable "expiration_days" {
  description = "Number of days before object expires"
  type        = string
}

variable "noncurrent_version_expiration" {
  description = "Days after which non-current versions expire"
  type        = number
  default     = 90
}

variable "force_destroy" {
  description = "Allow deletion of non-empty bucket"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
