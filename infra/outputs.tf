output "dynamo_table_name" {
  value = module.dynamodb.table_name
}

output "ecr_repo_url" {
  value = module.ecr.repo_url
}