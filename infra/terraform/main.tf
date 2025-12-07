provider "aws" {
  region                      = var.region
  access_key                  = var.aws_access_key
  secret_key                  = var.aws_secret_key
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  s3_force_path_style         = true
  endpoints {
    dynamodb        = var.localstack_endpoint
    s3              = var.localstack_endpoint
    sqs             = var.localstack_endpoint
    lambda          = var.localstack_endpoint
    iam             = var.localstack_endpoint
    apigateway      = var.localstack_endpoint
    secretsmanager  = var.localstack_endpoint
  }
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
  tags        = {}
}

module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = var.table_name
  tags       = {}
}

module "sqs" {
  source                     = "./modules/sqs"
  name                       = "document-queue"
  visibility_timeout_seconds = 60
  message_retention_seconds  = 1209600
  max_receive_count          = 5
  tags                       = {}
}

module "eventbridge" {
  source              = "./modules/eventbridge"
  bus_name            = var.bus_name
  validated_target_arn = var.validated_target_arn
}

module "lambda_validator" {
  source         = "./modules/lambda"
  function_name  = var.function_name
  artifact_path  = "${path.module}/artifacts/validator.zip"
  handler        = var.handler
  runtime        = var.runtime
  s3_bucket      = module.s3.bucket_name
  dynamodb_table = module.dynamodb.table_name
  event_bus_name = module.eventbridge.bus_name
  region         = var.region
  environment    = var.environment
  tags           = var.tags
}
