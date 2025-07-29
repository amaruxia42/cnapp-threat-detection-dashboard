#/cnapp_threat_detection_dashboard/terraform/main.tf
module "cloudtrail" {
  source                        = "../modules/cloudtrail"
  cloudtrail_name               = "cnapp-dev-trail"
  s3_bucket_name                = module.s3.log_bucket_name
  include_global_service_events = true
  is_multi_region_trail         = true

  data_event_resources = [
    {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::cnapp-dev-bucket/"]
    }
  ]

  tags = {
    Environment = "dev"
    Project     = "CNAPP"
  }
}

module "eventbridge" {
  source               = "../modules/eventbridge"
  description          = ""
  lambda_function_arn  = module.lambda.lambda_function_arn
  lambda_function_name = module.lambda.lambda_function_name
  rule_name            = "cnapp-guardduty-event-rule"

  tags = {
    Environment = "dev"
    Project     = "CNAPP"
  }
}

module "guardduty" {
  source = "../modules/guardduty"

  enable_s3_protection         = true
  enable_kubernetes_audit_logs = true
  enable_malware_protection    = true

  tags = {
    Project     = "CNAPP"
    Environment = "dev"
  }
}

module "iam" {
  source           = "../modules/iam"
  log_bucket_name  = module.s3.log_bucket_name
  lambda_role_name = { name = "cnapp-lambda-dev-role" }

  tags = {
    Environment = "dev"
    Project     = "CNAPP"
  }
}

module "lambda" {
  source               = "../modules/lambda"
  lambda_function_name = "cnapp-threat-detection"
  lambda_handler       = "threat_detection.handler.lambda_handler"
  lambda_package_path  = "${path.root}/../modules/lambda/build/threat_detection.zip"
  lambda_role_arn      = module.iam.lambda_role_arn
  lambda_runtime       = "python3.13"
}

module "s3" {
  source                        = "../modules/s3"
  log_bucket_name               = "cnapp-logs-dev-${random_string.suffix.result}"
  expiration_days               = 180
  noncurrent_version_expiration = 60
  force_destroy                 = true

  tags = {
    Project     = "CNAPP"
    Environment = "dev"
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

module "sec_hub" {
  source                           = "../modules/securityhub"
  auto_enable_controls             = true
  enable_cis_standard              = true
  enable_aws_foundational_standard = true
}

module "sns" {
  source               = "../modules/sns_alerts"
  topic_name           = "cnapp-alerts-dev"
  email_subscriptions  = [""]
  allowed_publish_arns = [module.eventbridge.event_rule_arn]

  tags = {
    Project     = "CNAPP"
    Environment = "dev"
  }
}