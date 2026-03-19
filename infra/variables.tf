variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "dynamodb_table_name" {
  type    = string
  default = "snip-infra"
}

variable "project_name" {
  type    = string
  default = "snip-infra"
}

variable "environment" {
  type    = string
  default = "dev"
}