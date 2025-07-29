#/cnapp_threat_detection_dashboard/modules/security_hub/variables.tf
variable "auto_enable_controls" {
  description = "Automatically enable newly released controls"
  type        = bool
  default     = true
}

variable "enable_cis_standard" {
  description = "Enable CIS AWS Foundations Benchmark v1.4.0"
  type        = bool
  default     = true
}

variable "enable_aws_foundational_standard" {
  description = "Enable AWS Foundational Security Best Practices"
  type        = bool
  default     = true
}

# variable "tags" {
#   description = "Tags to apply to Security Hub resources"
#   type        = map(string)
#   default     = {}
# }