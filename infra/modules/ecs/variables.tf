variable "project_name" {
  type    = string
  default = "snip-infra"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "vpc_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}

variable "dynamodb_table_arn" {
  type = string
}

variable "ecr_image_url" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "dynamodb_table_name" {
  type = string
}


variable "alb_dns_name" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}