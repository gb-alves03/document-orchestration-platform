resource "aws_dynamodb_table" "audit" {
  name = "document-audit"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "documentId"


  attribute {
    name = "documentId"
    type = "S"
  }


  attribute {
    name = "timestamp"
    type = "S"
  }
}