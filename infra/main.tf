provider "aws" {
  region = var.aws_region
}

module "dynamodb" {
    source = "./modules/dynamodb"

    table_name = var.dynamodb_table_name
    project_name = var.project_name
    environment = var.environment
}

module "ecr" {
  source = "./modules/ecr"
  repository_name = var.project_name
  project_name = var.project_name
  environment = var.environment
}