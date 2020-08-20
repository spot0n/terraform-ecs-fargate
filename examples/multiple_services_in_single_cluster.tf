provider "aws" {
  version = "~> 2.66"
  region = "us-east-1"
}

locals {
  az_count = 2
}

# Create required network Topology
# network.tf

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}

resource "aws_vpc" "main" {
  cidr_block = "172.17.0.0/16"
  tags = {
    Name = "vpc for fargate services"
  }
}

# Create local.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {
  count                   = local.az_count
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, local.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags = {
    Name = "example-public-${count.index}"
  }
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "IGW for fargate services"
  }
}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster-with-multiple-services"
}

module "service-1" {
  source              = "../terraform"
  ecs_task_execution_role_name = "service-1"
  aws_ecs_cluster     = aws_ecs_cluster.main
  app_name            = "service-1"
  alb_subnets         = aws_subnet.public.*.id
  ecs_service_subnets = aws_subnet.public.*.id
  aws_vpc_id          = aws_vpc.main.id
}

module "service-2" {
  source              = "../terraform"
  ecs_task_execution_role_name = "service-2"
  aws_ecs_cluster     = aws_ecs_cluster.main
  app_name            = "service-2"
  alb_subnets         = aws_subnet.public.*.id
  ecs_service_subnets = aws_subnet.public.*.id
  aws_vpc_id          = aws_vpc.main.id
}