terraform {
  required_version = "~> 1.3"

  backend "s3" {
    bucket         = "apinfra-tfstate"
    key            = "apinfra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "apinfra-tfstate-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.31"
    }
  }
}

# data "terraform_remote_state" "tf_state" {
#   backend = "s3"
#   config = {
#     bucket = "apinfra-tfstate"
#     key    = "apinfra/terraform.tfstate"
#     region = "us-east-1"
#   }
# }

module "tf-state" {
  source              = "./modules/tf-state"
  bucket_name         = local.bucket_name
  dynamodb_table_name = local.dynamodb_table_name
}

module "ecr_repo" {
  source        = "./modules/ecr"
  ecr_repo_name = local.ecr_repo_name
}

resource "aws_vpc" "apinfra_vpc" {
  cidr_block           = local.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "apinfra-vpc"
  }
}

resource "aws_internet_gateway" "apinfra_igw" {
  vpc_id = aws_vpc.apinfra_vpc.id
}

resource "aws_internet_gateway_attachment" "apinfra_igw" {
  vpc_id              = aws_vpc.apinfra_vpc.id
  internet_gateway_id = aws_internet_gateway.apinfra_igw.id
}

resource "aws_route_table" "apinfra_rtb" {
  vpc_id = aws_vpc.apinfra_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.apinfra_igw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  for_each = { for id, subnet in module.ecs_cluster.subnet_info : id => subnet if subnet.map_public_ip_on_launch }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.apinfra_rtb.id
}

module "ecs_cluster" {
  source                       = "./modules/ecs"
  vpc_id                       = aws_vpc.apinfra_vpc.id
  ecr_repo_url                 = module.ecr_repo.ecr_repo_url
  cluster_name                 = local.ecs_cluster_name
  service_name                 = local.ecs_service_name
  ecs_task_execution_role_name = local.ecs_task_execution_role_name
  task_container_port          = local.task_container_port
  task_cpu                     = local.task_cpu
  task_memory                  = local.task_memory
  task_family                  = local.task_family
  target_group_name            = local.target_group_name
  task_host_port               = local.task_host_port
  task_name                    = local.task_name
  service_desired_count        = local.service_desired_count
  alb_name                     = local.alb_name
  subnets                      = local.subnets
}
