#/cnapp_threat_detection_dashboard/terraform/modules/iam/iam.tf
data "aws_caller_identity" "current" {}

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
        Resource = [
          "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${var.lambda_function_name}:*"
        ]
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
  "arn:aws:s3:::${var.log_bucket_name}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
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
          "cloudtrail:LookupEvents",
          "s3:GetBucketAcl",
          "s3:PutObject"
        ],
        Resource = ["arn:aws:s3:::${var.log_bucket_name}",
        "arn:aws:s3:::${var.log_bucket_name}/*"]
      },
      {
        Sid      = "AWSCloudTrailAclCheck",
        Effect   = "Allow",
        Action   = "s3:GetBucketAcl",
        Resource = "arn:aws:s3:::${var.log_bucket_name}"
      },
      {
        Sid      = "AWSCloudTrailWrite",
        Effect   = "Allow",
        Action   = "s3:PutObject",
        Resource = "arn:aws:s3:::${var.log_bucket_name}/AWSLogs/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      },
      {
        Sid    = "SNSPublish",
        Effect = "Allow",
        Action = [
          "sns:Publish"
        ],
        Resource = "arn:aws:sns:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${var.sns_topic_name}"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_cnapp_role.name
  policy_arn = aws_iam_policy.lambda_cnapp_policy.arn
}





