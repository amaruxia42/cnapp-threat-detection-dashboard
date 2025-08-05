#/cnapp_threat_detection_dashboard/modules/sns_alerts/variables.tf
variable "topic_name" {
  description = "Name of SNS topic"
  type        = string
}

variable "email_subscriptions" {
  description = "List of email addresses to subscribe"
  type        = list(string)
  default     = []
}

variable "allowed_publish_arns" {
  description = "List of ARNs allowed to publish to this topic"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "SNS tag description"
  type        = map(string)
  default     = {}
}