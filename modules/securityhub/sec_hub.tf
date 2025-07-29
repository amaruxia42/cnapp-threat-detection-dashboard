#/cnapp_threat_detection_dashboard/modules/security_hub/sec_hub.tf
resource "aws_securityhub_account" "sec_hub" {
  auto_enable_controls      = var.auto_enable_controls
  control_finding_generator = "SECURITY_CONTROL"
}

resource "aws_securityhub_standards_subscription" "cis" {
  count         = var.enable_cis_standard ? 1 : 0
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/cis-aws-foundations-benchmark/v/1.4.0"
}

resource "aws_securityhub_standards_subscription" "aws_foundational" {
  count         = var.enable_aws_foundational_standard ? 1 : 0
  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/aws-foundational-security-best-practices/v/1.0.0"
}

data "aws_region" "current" {}
