variable "aws_access_key" {
  type    = string
  default = "test"
}

variable "aws_secret_key" {
  type    = string
  default = "test"
}

variable "localstack_endpoint" {
  type    = string
  default = "http://localhost:4566"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

# S3 module inputs
variable "bucket_name" {
  type    = string
  default = "document-orchestrator-bucket"
}

variable "expire_days" {
  type    = number
  default = 365
}

variable "raw_prefix" {
  type    = string
  default = "raw/"
}

# DynamoDB module inputs
variable "table_name" {
  type    = string
  default = "document-orchestrator-table"
}

variable "hash_key" {
  type    = string
  default = "documentId"
}

variable "hash_key_type" {
  type    = string
  default = "S"
}

variable "sort_key" {
  type    = string
  default = ""
}

variable "sort_key_type" {
  type    = string
  default = "S"
}

# SQS module inputs
variable "sqs_name" {
  type    = string
  default = "document-queue"
}

variable "visibility_timeout_seconds" {
  type    = number
  default = 60
}

variable "message_retention_seconds" {
  type    = number
  default = 1209600
}

variable "max_receive_count" {
  type    = number
  default = 5
}

# EventBridge
variable "bus_name" {
  type    = string
  default = "document-bus"
}

variable "validated_target_arn" {
  type    = string
  default = ""
}

# Lambda module inputs
variable "function_name" {
  type    = string
  default = "document-validator"
}

variable "handler" {
  type    = string
  default = "com.example.lambda.Validator::handleRequest"
}

variable "runtime" {
  type    = string
  default = "java11"
}

# Common
variable "environment" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
