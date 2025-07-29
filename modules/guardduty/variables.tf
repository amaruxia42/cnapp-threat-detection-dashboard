# cnapp_threat_detection/modules/guardduty/variables.tf
variable "enable_s3_protection" {
  description = "Enable GuardDuty S3 data event protection"
  type        = bool
  default     = true
}

variable "enable_kubernetes_audit_logs" {
  description = "Enable EKS audit log monitoring"
  type        = bool
  default     = false
}

variable "enable_malware_protection" {
  description = "Enable malware protection for EC2 with EBS volumes"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to GuardDuty resources"
  type        = map(string)
  default     = {}
}