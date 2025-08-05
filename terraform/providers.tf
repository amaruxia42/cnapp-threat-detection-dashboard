#/cnapp_threat_detection_dashboard/terraform/providers.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# AWS Provider
provider "aws" {
  region = "us-east-1"
}