variable "subnets" {
  description = "A map of subnet configurations."
  type = map(object({
    cidr_block              = string
    availability_zone       = string
    map_public_ip_on_launch = optional(bool, false) # Default to false for private subnets
  }))
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
}

variable "task_family" {
  description = "The family of the task definition."
  type        = string
}

variable "task_name" {
  description = "The name of the container."
  type        = string
}

variable "ecr_repo_url" {
  description = "The URL of the ECR repository."
  type        = string
}

variable "task_container_port" {
  description = "The port on which the container listens."
  type        = number
}

variable "task_host_port" {
  description = "The port on the host that maps to the container port."
  type        = number
}

variable "task_memory" {
  description = "The amount of memory (in MiB) to allocate to the task."
  type        = number
}

variable "task_cpu" {
  description = "The amount of CPU to allocate to the task."
  type        = number
}

variable "service_desired_count" {
  description = "The desired number of services to run."
  type        = number
}

variable "service_name" {
  description = "The name of the ECS service."
  type        = string
}

variable "target_group_name" {
  description = "The name of the target group."
  type        = string
}

variable "alb_name" {
  description = "The name of the ALB."
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "The name of the ECS task execution role."
  type        = string
}

variable "aws_region" {
  type = string
}
