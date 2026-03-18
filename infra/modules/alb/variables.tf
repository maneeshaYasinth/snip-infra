variable "project" {
  type = string
  default = "snip-infra"
}

variable "vpc_id" {
  type = string
  description = "VPC ID"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "public_subnet_ids" {
  type = list(string)
  description = "Public subnet IDs for ALB"
}