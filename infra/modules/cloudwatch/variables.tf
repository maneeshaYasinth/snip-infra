variable "project_name" {
  description = "The name of the project, used for naming resources"
  type        = string
  default = "snip-infra"
}

variable "region" {
  type = string
  default = "value"
}

variable "alb_arn_suffix" {
  type = string
}

variable "dynamodb_table_name" {
  type = string
}

variable "environment" {
  type = string
  default = "devß"
}