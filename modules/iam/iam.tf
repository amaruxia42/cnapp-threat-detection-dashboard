#/cnapp_threat_detection_dashboard/terraform/modules/iam/iam.tf
resource "aws_iam_role" "lambda_cnapp_role" {
  name = var.lambda_role_name.name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = var.tags
}

resource "aws_iam_policy" "lambda_cnapp_policy" {
  name = "${var.lambda_role_name.name}-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "CloudWatchLogs",
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
      {
        Sid    = "S3Access",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ],
        Resource = [
          "arn:aws:s3:::${var.log_bucket_name}",
          "arn:aws:s3:::${var.log_bucket_name}/*"
        ]
      },
      {
        Sid    = "GuardDutyReadAccess",
        Effect = "Allow",
        Action = [
          "guardduty:GetFindings",
          "guardduty:ListFindings"
        ],
        Resource = "*"
      },
      {
        Sid    = "SecurityHubReadAccess",
        Effect = "Allow",
        Action = [
          "securityhub:GetFindings",
          "securityhub:DescribeHub",
          "securityhub:GetEnabledStandards",
          "securityhub:DescribeStandards"
        ],
        Resource = "*"
      },
      {
        Sid    = "CloudTrailReadAccess",
        Effect = "Allow",
        Action = [
          "cloudtrail:LookupEvents"
        ],
        Resource = "*"
      },
      {
        Sid    = "SNSPublish",
        Effect = "Allow",
        Action = [
          "sns:Publish"
        ],
        Resource = "*"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_cnapp_role.name
  policy_arn = aws_iam_policy.lambda_cnapp_policy.arn
}