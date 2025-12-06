resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}


resource "aws_lambda_function" "validator" {
  function_name = "document-validator"
  role = aws_iam_role.lambda_exec.arn
  handler = "com.example.lambda.Validator::handleRequest"
  runtime = "java11"
  filename = "${path.module}/../artifacts/validator.zip"
  source_code_hash = filebase64sha256("${path.module}/../artifacts/validator.zip")


  environment {
    variables = {
      S3_BUCKET = var.bucket
      DYNAMO_TABLE = var.audit_table
    }
  }
}