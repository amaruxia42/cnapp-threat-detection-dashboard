#/cnapp_threat_detection_dashboard/terraform/variables.tf
variable "s3_bucket_name" {
  description = "Name of S3 bucket designated for publishing logs"
  type        = string
}

variable "cloudtrail_name" {
  description = "Name of the CloudTrail trail"
  type        = string
}

variable "include_global_service_events" {
  description = "Publishing events from global services,IAM etc"
  type        = string
}

variable "is_multi_region_trail" {
  description = "The trail is created in all regions"
  type        = string
}

variable "data_event_resources" {
  description = "data events"

  type = list(object({
    type   = string
    values = list(string)
  }))
  default = []
}

variable "tags" {
  description = "Name tag to apply to resources"
  type        = map(string)
  default     = {}
}