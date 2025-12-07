variable "table_name" {
  type = string
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

variable "tags" {
  type    = map(string)
  default = {}
}

resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  dynamic "attribute" {
    for_each = var.sort_key == "" ? [] : [1]
    content {
      name = var.sort_key
      type = var.sort_key_type
    }
  }

  tags = var.tags
}
