output "cloudfront_domain" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.app.domain_name
}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.app.id
}