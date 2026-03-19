provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source      = "./modules/vpc"
  project     = var.project_name
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

  table_name   = var.dynamodb_table_name
  project_name = var.project_name
  environment  = var.environment
}

module "ecr" {
  source          = "./modules/ecr"
  repository_name = var.project_name
  project_name    = var.project_name
  environment     = var.environment
}

module "ecs" {
  source              = "./modules/ecs"
  project_name        = var.project_name
  environment         = var.environment
  aws_region          = var.aws_region
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_id
  alb_sg_id           = module.alb.alb_sg_id
  target_group_arn    = module.alb.target_group_arn
  alb_dns_name        = module.alb.alb_dns_name
  ecr_image_url       = "${module.ecr.repo_url}:latest"
  dynamodb_table_name = module.dynamodb.table_name
  dynamodb_table_arn  = module.dynamodb.table_arn
}