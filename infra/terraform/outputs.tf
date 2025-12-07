output "bucket_name" {
  value = module.s3.bucket_name
}

output "bucket_arn" {
  value = module.s3.bucket_arn
}

output "queue_url" {
  value = module.sqs.queue_url
}

output "queue_arn" {
  value = module.sqs.queue_arn
}

output "dlq_url" {
  value = module.sqs.dlq_url
}

output "dlq_arn" {
  value = module.sqs.dlq_arn
}

output "table_name" {
  value = module.dynamodb.table_name
}

output "bus_name" {
  value = module.eventbridge.bus_name
}

output "document_validated_rule_name" {
  value = module.eventbridge.document_validated_rule_name
}

output "lambda_arn" {
  value = module.lambda_validator.lambda_arn
}

output "lambda_name" {
  value = module.lambda_validator.lambda_name
}
