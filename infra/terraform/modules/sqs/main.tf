terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.1"
    }
  }
}
resource "aws_sqs_queue" "document_uploaded" {
  name = "document-uploaded"
  visibility_timeout_seconds = 60
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "document_invalid" {
  name = "document-invalid"
}

resource "aws_sqs_queue_policy" "allow" {
  queue_url = aws_sqs_queue.document_uploaded.id
  policy    = jsondecode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sqs:SendMessage",
        Effect = "Allow",
        Principal = "*",
        Resource = aws_sqs_queue.document_uploaded.arn
      }
    ]
  })
}

output "queue_url" {
  value = aws_sqs_queue.document_uploaded.id
}