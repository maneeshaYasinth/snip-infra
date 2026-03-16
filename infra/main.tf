provider "aws" {
  region = var.aws_region
}

module "dynamodb" {
    source = "modules/dynamodb"

    table_name = var.dynamodb_table_name
    project = var.project_name
    environment = var.environment
}

module "ecr" {
  source = "modules/ecr"
  repo_name = var.project_name
  project = var.project_name
  enviroment = var.enviroment
}