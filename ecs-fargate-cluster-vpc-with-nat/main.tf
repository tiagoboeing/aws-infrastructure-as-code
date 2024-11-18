
locals {
  service_name = "${var.service}-${var.stage}"
}

# Get AWS Account ID
data "aws_caller_identity" "current" {}

# Certificate
module "acm" {
  source               = "./modules/acm"
  domain               = var.domain
  route53_base_domain  = var.route53_base_domain
  route53_private_zone = var.route53_private_zone

  providers = {
    aws = aws
  }
}

# Container registry
module "ecr" {
  source          = "./modules/ecr"
  repository_name = var.ecr_repository_name

  providers = {
    aws = aws
  }
}

# module "ecs" {
#   source  = "./modules/ecs"
#   region  = var.region
#   alb_arn = module.alb.aws_lb_tfer--alb-0f2f0fc8f728581b0_arn
#   ecr_id  = module.ecr.aws_ecr_repository_tfer--ecs-0f2f0fc8f728581b0_id
# }

# module "igw" {
#   source = "./modules/igw"
#   region = var.region
# }

# module "nat" {
#   source = "./modules/nat"
#   region = var.region
#   vpc_id = module.vpc.aws_vpc_tfer--vpc-0f2f0fc8f728581b0_id
# }

# module "route_table" {
#   source = "./modules/route-table"
#   region = var.region
#   vpc_id = module.vpc.aws_vpc_tfer--vpc-0f2f0fc8f728581b0_id
#   igw_id = module.igw.aws_internet_gateway_tfer--igw-0f2f0fc8f728581b0_id
# }

# Network
module "vpc" {
  source       = "./modules/vpc"
  service_name = local.service_name

  providers = {
    aws = aws
  }
}

module "subnet" {
  source       = "./modules/subnet"
  service_name = local.service_name
  vpc_id       = module.vpc.aws_vpc_id

  depends_on = [module.vpc.aws_vpc_id]

  providers = {
    aws = aws
  }
}

module "security_group" {
  source       = "./modules/sg"
  vpc_id       = module.vpc.aws_vpc_id
  service_name = local.service_name

  providers = {
    aws = aws
  }
}

module "alb" {
  source                = "./modules/alb"
  service_name          = local.service_name
  alb_security_group_id = module.security_group.aws_security_group_cluster_from_internet_to_alb_id

  public_subnet_ids = [
    module.subnet.aws_subnet_public1_az_1a_id,
    module.subnet.aws_subnet_public2_az_1b_id
  ]

  providers = {
    aws = aws
  }
}
