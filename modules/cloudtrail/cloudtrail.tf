#/cnapp_threat_detection_dashboard/terraform/cloudtrail.tf
resource "aws_cloudtrail" "cloudtrail_cnapp" {
  name                          = var.cloudtrail_name
  s3_bucket_name                = var.s3_bucket_name
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  enable_logging                = true

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    dynamic "data_resource" {
      for_each = var.data_event_resources
      iterator = event_resources
      content {
        type   = event_resources.value.type
        values = event_resources.value.values
      }
    }
  }

  tags = var.tags
}