# Scalable ECS Deployment with Terraform

This repository provides an automated infrastructure setup for deploying a scalable ECS (Elastic Container Service) architecture using Terraform. The project includes modules for ECS resources (tasks, services, clusters), ECR (Elastic Container Registry), and Terraform state management. GitHub Actions is used for CI/CD workflows to automate deployments, linting, and other tasks.

## Project Overview

This project sets up a scalable ECS environment using Terraform, which allows you to:

- Define and deploy ECS services, tasks, and clusters.
- Create and manage ECR repositories for storing Docker images.
- Automate deployment processes using GitHub Actions.
- Manage the Terraform state in a secure and scalable way.

### Key Components

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
