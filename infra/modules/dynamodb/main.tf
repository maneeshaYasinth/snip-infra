resource "aws_dynamodb_table" "url_shortener" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "shortCode"

  attribute {
    name = "shortCode"
    type = "S"
  }

  ttl {
    attribute_name = "expiresAt"
    enabled = true
  }

  tags = {
    Project = var.project_name
    Enviroment = var.enviroment
  }
  
}