terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.1"
    }
  }
}
variable "bucket_name" {
  default = ""
}

resource "aws_s3_bucket" "documents" {
  bucket = var.bucket_name
  acl = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id = "expire-unsigned"
    enabled = true
    expiration {
      days = 365
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = "aws_s3_bucket.documents.id"
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

output "bucket_name" {
  value = "aws_s3_bucket.documents.bucket"
}