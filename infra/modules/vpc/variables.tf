variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "project" {
  type = string
  default = "snip-infra"
}

variable "environment" {
  type = string
  default = "dev"
}