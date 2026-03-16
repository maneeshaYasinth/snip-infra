output "table_name" {
  value = aws_dynamodb_table.url_shortener.name
}

output "table_arn" {
  value = aws_dynamodb_table.url_shortener.arn
}