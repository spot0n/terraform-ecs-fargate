# variables.tf

variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "myEcsTaskExecutionRole"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "bradfordhamilton/crystal_blockchain:latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 3000
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "min_app_count" {
  description = "Minimum number of docker containers to run"
  default     = 1
}

variable "max_app_count" {
  description = "Maximum number of docker containers to run"
  default     = 1
}

variable "health_check_path" {
  default = "/health"
}

variable "health_check_timeout" {
  default = 3
}

variable "health_check_unhealthy_threshold" {
  default = 3
}

variable "health_check_interval" {
  default = 30
}

variable "health_check_healthy_threshold" {
  default = 3
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "1024"
}

variable "aws_ecs_cluster" {
  description = "ECS cluster ID used for creating ECS service"
}

variable "app_name" {
  description = "ECS Service name"
}

variable "alb_subnets" {
  description = "Subnets to use for ALB"
}

variable "ecs_service_subnets" {
  description = "Subnets to use for ECS Service"
}


variable "aws_vpc_id" {
  description = "VPC ID to be used for building service and ALB"
}