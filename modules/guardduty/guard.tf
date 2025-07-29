# cnapp_threat_detection/modules/guardduty/guard.tf
resource "aws_guardduty_detector" "cnapp_detector" {
  enable = true
  tags   = var.tags
}

resource "aws_guardduty_detector_feature" "s3_protection" {
  count       = var.enable_s3_protection ? 1 : 0
  detector_id = aws_guardduty_detector.cnapp_detector.id
  name        = "S3_DATA_EVENTS"
  status      = "ENABLED"
}

resource "aws_guardduty_detector_feature" "eks_audit_logs" {
  count       = var.enable_kubernetes_audit_logs ? 1 : 0
  detector_id = aws_guardduty_detector.cnapp_detector.id
  name        = "EKS_AUDIT_LOGS"
  status      = "ENABLED"
}

resource "aws_guardduty_detector_feature" "malware_protection" {
  count       = var.enable_malware_protection ? 1 : 0
  detector_id = aws_guardduty_detector.cnapp_detector.id
  name        = "EBS_MALWARE_PROTECTION"
  status      = "ENABLED"
}