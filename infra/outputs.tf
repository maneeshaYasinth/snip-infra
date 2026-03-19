output "dynamo_table_name" {
  value = module.dynamodb.table_name
}

output "ecr_repo_url" {
  value = module.ecr.repo_url
}

output "app_url" {
  description = "Access the app here"
  value       = "http://${module.alb.alb_dns_name}"
}