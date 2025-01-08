provider "aws" {
  region = "us-east-1"
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  cidr_block     = "10.0.0.0/16"
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}

# Auto Scaling Group Module
module "asg" {
  source             = "./modules/asg_module"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  ami_id             = "ami-0ca9fb66e076a6e32"
  instance_type      = "t2.micro"
  key_name           = "terra"
  desired_capacity   = 2
  max_size           = 4
  min_size           = 1
}

# S3 Module
module "s3" {
  source              = "./modules/s3"
  bucket_name         = "testing-e-123456"
  logging_bucket_name = "my-logging-bucket"
  environment         = "Dev"
  transition_days     = 30
  expiration_days     = 365
}

# IAM Module
module "iam" {
  source       = "./modules/iam"
  role_name    = "my-app-role"
  policy_name  = "my-app-policy"
}

