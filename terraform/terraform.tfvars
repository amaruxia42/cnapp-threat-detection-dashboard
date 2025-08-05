aws_region            = "us-east-1"
cloudtrail_name       = "cnapp-dev-trail"
eventbridge_desc      = "CNAPP (Lite) Threat Detection EventBridge Dashboard"
guardduty_event_rules = "cnapp-threat-detection-guardduty-event-rule"
lambda_function_name  = "cnapp-threat-detection"
lambda_handler        = "threat_detection.handler.lambda_handler"
lambda_role_name = {
  name                =  "cnapp-lambda-threat-detection-role"
}
lambda_runtime        =  "python3.13"
log_bucket_name       = "cnapp-threat-detection-logs" 
sns_topic_name        = "cnapp-threat-detection-security-signal-alerts"
tags = {
    Enviroment        = "dev"
    Project           = "CNAPP"
}