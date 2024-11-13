
locals {
  service_name = "${var.service}-${var.stage}"
}

# Get AWS Account ID
data "aws_caller_identity" "current" {}

# Modules
module "acm" {
  source               = "./modules/acm"
  region               = var.region
  domain               = var.domain
  route53_base_domain  = var.route53_base_domain
  route53_private_zone = var.route53_private_zone
}

# module "alb" {
#   source = "./modules/alb"
#   region = var.region
# }

module "ecr" {
  source          = "./modules/ecr"
  region          = var.region
  repository_name = var.ecr_repository_name
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

# module "security_group" {
#   source = "./modules/sg"
#   region = var.region
#   vpc_id = module.vpc.aws_vpc_tfer--vpc-0f2f0fc8f728581b0_id
# }

# Network
module "vpc" {
  source       = "./modules/vpc"
  region       = var.region
  service_name = local.service_name
}

module "subnet" {
  source       = "./modules/subnet"
  region       = var.region
  service_name = local.service_name
  vpc_id       = module.vpc.aws_vpc_id

  depends_on = [module.vpc]
}
