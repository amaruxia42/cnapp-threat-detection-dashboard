#/cnapp_threat_detection_dashboard/terraform/main.tf
module "cloudtrail" {
  source = "../modules/cloudtrail"

  cloudtrail_name               = var.cloudtrail_name
  s3_bucket_name                = module.s3.log_bucket_name
  include_global_service_events = true
  is_multi_region_trail         = true

  data_event_resources = [
    {
      type   = "AWS::S3::Object"
      values = ["arn:aws:s3:::${module.s3.log_bucket_name}/"]
    }
  ]

  tags = var.tags
}

module "eventbridge" {
  source = "../modules/eventbridge"

  description          = var.eventbridge_desc
  lambda_function_arn  = module.lambda.lambda_function_arn
  lambda_function_name = module.lambda.lambda_function_name
  rule_name            = var.guardduty_event_rules

  tags = var.tags
}

module "guardduty" {
  source = "../modules/guardduty"

  enable_s3_protection         = true
  enable_kubernetes_audit_logs = true
  enable_malware_protection    = true

  tags = var.tags
}

module "iam" {
  source               = "../modules/iam"

  log_bucket_name      = module.s3.log_bucket_name
  lambda_role_name     = var.lambda_role_name
  aws_region           = var.aws_region
  lambda_function_name = module.lambda.lambda_function_name 
  sns_topic_name       = var.sns_topic_name

  tags = var.tags
}

module "lambda" {
  source = "../modules/lambda"

  lambda_function_name = var.lambda_function_name
  lambda_handler       = var.lambda_handler
  lambda_package_path  = "${path.root}/../modules/lambda/build/threat_detection.zip"
  lambda_role_arn      = module.iam.lambda_role_arn
  lambda_runtime       = var.lambda_runtime
}

module "s3" {
  source = "../modules/s3"

  log_bucket_name               = "${var.log_bucket_name}-${random_string.suffix.result}"
  expiration_days               = 180
  noncurrent_version_expiration = 60
  force_destroy                 = true

  tags = var.tags
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

module "sns" {
  source = "../modules/sns_alerts"

  topic_name           = var.sns_topic_name
  email_subscriptions  = ["securityteam@example.com"]
  allowed_publish_arns = [module.eventbridge.event_rule_arn]

  tags = var.tags
}

