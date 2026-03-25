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

output "cloudfront_url" {
  description = "Access the app via CloudFront"
  value       = "https://${module.cloudfront.cloudfront_domain}"
}

output "cloudwatch_dashboard" {
  value = "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#dashboards:name=${module.cloudwatch.dashboard_name}"
}