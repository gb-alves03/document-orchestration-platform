variable "expire_days" {
  type    = number
  default = 365
}
variable "raw_prefix" {
  type    = string
  default = "raw/"
}
variable "bucket_name" {
  default = "document-orchestrator-bucket"
}

variable "tags" {
  type    = map(string)
  default = {}
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id      = "expire-unsigned"
    enabled = true
    expiration {
      days = var.expire_days
    }
    prefix = var.raw_prefix
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}