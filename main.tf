provider "aws" {
  region = "us-east-2"
}

module "iam_role" {
  source = "./iam_role"
  varDevs = "devs"
}

module "s3_bucket" {
  source = "./s3_bucket"
  Repository = "repository"
}

module "ec2_instance" {
  source = "./ec2_instance"
  VarProduction = "production-server-1"
}