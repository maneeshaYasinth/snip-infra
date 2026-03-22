variable "project_name" {
  type    = string
  default = "snip-infra"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "alb_dns_name" {
  description = "ALB DNS name to use as CloudFront origin"
  type        = string
}