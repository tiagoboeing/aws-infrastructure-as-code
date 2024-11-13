# ECS Fargate Cluster + VPC with NAT Gateway

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)

Elastic Container Service (ECS) Fargate Cluster with VPC, NAT Gateway, Internet Gateway and custom domain with SSL using Terraform.

**See [API Docs](./api-docs.md) for reference.**

> [!NOTE]
>
> Part of this project was based on [Cleber Gasparotto's repository](https://github.com/chgasparoto/youtube-cleber-gasparoto/tree/main/0007-aws-ecs-fargate/app). Check his [YouTube Channel](https://www.youtube.com/c/CleberGasparotto) for more content.

The provisioned resources follow the diagram below (created by Cleber Gasparotto):

![Architecture](./docs/aws-diagram.jpg)

## Stack

- ECS Fargate Cluster (free, pay-per-use)
- VPC (CIDR block fixed on `10.0.0.0/16` range to easily control this project, change it if needed)
  - Subnets - 2 Availabity Zones with 1 public subnet + 1 private subnet each
  - Security Groups
  - Route Tables
  - Internet Gateway
  - NAT Gateway
  - Elastic IP 
- Amazon Certificate Manager
  - Custom SSL Certificate

### Tags

This project will apply the following tags to all resources:

- `service` - The name of the service
- `stage` - The stage of the service (e.g. dev, prod)

> Check the `default_tags` map on [`provider.tf`](./provider.tf) file.

## Requirements

- Before starting, you need to have a Route53 hosted zone in your AWS account.