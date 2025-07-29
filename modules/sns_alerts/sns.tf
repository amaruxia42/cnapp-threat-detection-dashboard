#/cnapp_threat_detection_dashboard/modules/sns_alerts/sns.tf
resource "aws_sns_topic" "cnapp_alerts" {
  name = var.topic_name
  tags = var.tags
}

resource "aws_sns_topic_subscription" "email" {
  for_each = toset(var.email_subscriptions)

  topic_arn = aws_sns_topic.cnapp_alerts.arn
  protocol  = "email"
  endpoint  = each.key
}

resource "aws_sns_topic_policy" "allow_publish" {
  count = var.allowed_publish_arns != [] ? 1 : 0

  arn    = aws_sns_topic.cnapp_alerts.arn
  policy = data.aws_iam_policy_document.allow_publish.json
}

data "aws_iam_policy_document" "allow_publish" {
  statement {
    actions = ["sns:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com", "lambda.amazonaws.com"]
    }

    resources = [aws_sns_topic.cnapp_alerts.arn]

    condition {
      test     = "ArnEquals"
      variable = "AWS:SourceArn"
      values   = var.allowed_publish_arns
    }
  }
}