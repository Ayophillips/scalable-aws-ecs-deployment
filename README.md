# Scalable ECS Deployment with Terraform

This repository provides an automated infrastructure setup for deploying a scalable ECS (Elastic Container Service) architecture using Terraform. The project includes modules for ECS resources (tasks, services, clusters), ECR (Elastic Container Registry), and Terraform state management. GitHub Actions is used for CI/CD workflows to automate deployments, linting, and other tasks.

## Project Overview

This project sets up a scalable ECS environment using Terraform, which allows you to:

- Define and deploy ECS services, tasks, and clusters.
- Create and manage ECR repositories for storing Docker images.
- Automate deployment processes using GitHub Actions.
- Manage the Terraform state in a secure and scalable way.

### Key Components

- **VPC Setup**:
  - Contains subnets, route tables, and an internet gateway to handle networking for ECS.
- **Terraform Modules**: 
  - ECS resources (clusters, services, and tasks)
  - ECR repository management
  - Terraform state management using S3 and DynamoDB
- **GitHub Actions**:
  - Continuous integration (CI) and continuous deployment (CD) for automated testing, linting, building Docker images, and deploying to ECS.

## Prerequisites

To use this repository and deploy the ECS infrastructure, you will need the following tools installed on your machine:

- [Terraform](https://www.terraform.io/downloads.html) - Infrastructure as code tool for provisioning resources.
- [AWS CLI](https://aws.amazon.com/cli/) - Command-line tool for interacting with AWS services.
- [Docker](https://www.docker.com/products/docker-desktop) - For building and pushing Docker images to ECR.
- [GitHub Account](https://github.com) - For hosting the repository and setting up GitHub Actions.

### Setup

Follow these steps to set up the project and deploy the infrastructure:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Ayophillips/scalable-aws-ecs-deployment.git
   cd scalable-aws-ecs-deployment

2. **Configure AWS CLI**:

   Ensure that the AWS CLI is configured with the correct credentials and region.
   
       aws configure

4. **Configure Input Parameters in locals.tf**:

  This project uses locals.tf to define input parameters for the infrastructure. You can customize your VPC, ECR, ECS cluster settings, etc., within this     file.
  
  Example of locals.tf:
  
    hcl
    
      locals {
        region              = "us-east-1"
        bucket_name         = "apinfra-tfstate"
        dynamodb_table_name = "apinfra-tfstate-locking"
        ecr_repo_name       = "apinfra-app-repo"
        cidr_block          = "10.0.0.0/16"
      
        ecs_cluster_name             = "apinfra-ecs-cluster"
        ecs_service_name             = "apinfra-ecs-service"
        task_name                    = "apinfra-ecs-task"
        alb_name                     = "apinfra-alb"
        task_cpu                     = 256
        task_memory                  = 512
        task_family                  = "apinfra-ecs-task"
        target_group_name            = "apinfra-ecs-target-group"
        task_host_port               = 3000
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

4. Set Up Environment Variables for GitHub Actions

  This project uses GitHub Secrets for AWS credentials in the GitHub Actions workflow. Set up the following secrets in your GitHub repository's Settings >    Secrets:
  
      AWS_ACCESS_KEY_ID
      AWS_SECRET_ACCESS_KEY

  In the GitHub Actions workflow file (.github/workflows/terraform-plan.yml, terraform-apply.yml), the AWS credentials are injected into the environment      variables as follows:

  yaml
  
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}

5. Initialize Terraform

  Run the following command to initialize Terraform and download the necessary providers:
  
      terraform init
  
6. Plan and Apply Terraform Configuration
  
  Run the following Terraform commands to review and apply the configuration. This will provision the ECS clusters, services, security groups, VPC, and       other resources in your AWS account:
  
      terraform plan
      terraform apply
  
  Confirm the apply when prompted. Terraform will provision your ECS infrastructure, including the VPC, subnets, security groups, and ECR repository.

7. Push Docker Images to ECR

  Once the infrastructure is set up, you need to push your Docker images to ECR. First, build your Docker image:
  
      docker build -t <your-image-name> .
  
  Then log into AWS ECR:
  
  
      $(aws ecr get-login --no-include-email --region <your-region>)
  
  Tag your image and push it to the ECR repository:
  
      docker tag <your-image-name>:latest <aws_account_id>.dkr.ecr.<region>.amazonaws.com/<your-ecr-repo>:latest
      docker push <aws_account_id>.dkr.ecr.<region>.amazonaws.com/<your-ecr-repo>:latest
