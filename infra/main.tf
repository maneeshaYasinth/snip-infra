provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  project = var.project_name
  environment = var.environment

}

module "alb" {
  source            = "./modules/alb"
  project           = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_id
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