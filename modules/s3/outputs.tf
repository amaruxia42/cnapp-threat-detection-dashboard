#/cnapp_threat_detection_dashboard/terraform/outputs.tf
output "log_bucket_name" {
  description = "ARN of S3 log bucket"
  value       = aws_s3_bucket.log_bucket.bucket
}

output "log_bucket_arn" {
  description = "ARN of S3 log bucket"
  value       = aws_s3_bucket.log_bucket.arn
}

output "log_bucket_id" {
  value = aws_s3_bucket.log_bucket.id
}