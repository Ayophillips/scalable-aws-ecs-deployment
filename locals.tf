locals {
  ecr_repo_name = "apinfra-app-repo"
  cidr_block    = "10.0.0.0/16"

  ecs_cluster_name             = "apinfra-ecs-cluster"
  ecs_service_name             = "apinfra-ecs-service"
  task_name                    = "apinfra-ecs-task"
  alb_name                     = "apinfra-alb"
  task_cpu                     = 256
  task_memory                  = 512
  task_family                  = "apinfra-ecs-task"
  target_group_name            = "apinfra-ecs-target-group"
  task_host_port               = 80
  task_container_port          = 3000
  service_desired_count        = 1
  ecs_task_execution_role_name = "apinfra-ecs-task-execution-role"
  subnets = {
    subnet_1 = {
      cidr_block              = "10.0.1.0/24"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = true
    }
    subnet_2 = {
      cidr_block              = "10.0.2.0/24"
      availability_zone       = "us-east-1b"
      map_public_ip_on_launch = true
    }
  }
}
