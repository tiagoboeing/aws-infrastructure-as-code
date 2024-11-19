
locals {
  service_full_name = "${var.service_name}-${var.stage}"
}

# Get AWS Account ID
data "aws_caller_identity" "current" {}

# Get AWS Region
data "aws_region" "current" {}

# Resource group
resource "aws_resourcegroups_group" "service" {
  name = local.service_full_name

  resource_query {
    query = <<JSON
    {
      "ResourceTypeFilters": ["AWS::AllSupported"],
      "TagFilters": [
        {
          "Key": "service",
          "Values": ["${local.service_full_name}"]
        }
      ]
    }
    JSON
  }

  tags = {
    Name = "${local.service_full_name}-rg"
  }
}

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

# Network
module "vpc" {
  source       = "./modules/vpc"
  service_name = local.service_full_name

  providers = {
    aws = aws
  }
}

module "subnet" {
  source       = "./modules/subnet"
  service_name = local.service_full_name
  vpc_id       = module.vpc.aws_vpc_id
  az_1         = var.subnet_az_1
  az_2         = var.subnet_az_2

  depends_on = [module.vpc.aws_vpc_id]

  providers = {
    aws = aws
  }
}

module "igw" {
  source       = "./modules/igw"
  service_name = local.service_full_name
  vpc_id       = module.vpc.aws_vpc_id

  depends_on = [module.vpc.aws_vpc_id]

  providers = {
    aws = aws
  }
}

module "security_group" {
  source       = "./modules/sg"
  vpc_id       = module.vpc.aws_vpc_id
  service_name = local.service_full_name

  depends_on = [module.vpc.aws_vpc_id]

  providers = {
    aws = aws
  }
}

module "elastic_ip" {
  source       = "./modules/elastic_ip"
  service_name = local.service_full_name
  region       = var.region
  # network_interface_az1_id = module.nat.aws_nat_gateway_nat_1_network_interface_id
  # network_interface_az2_id = module.nat.aws_nat_gateway_nat_2_network_interface_id

  # depends_on = [module.nat]

  providers = {
    aws = aws
  }
}

module "nat" {
  source                     = "./modules/nat"
  service_name               = local.service_full_name
  public_subnet_id_1         = module.subnet.aws_subnet_public1_az_1a_id
  public_subnet_id_2         = module.subnet.aws_subnet_public2_az_1b_id
  elastic_ip_1_allocation_id = module.elastic_ip.aws_eip_1_allocation_id
  elastic_ip_2_allocation_id = module.elastic_ip.aws_eip_2_allocation_id

  depends_on = [
    module.subnet,
    module.elastic_ip
  ]

  providers = {
    aws = aws
  }
}

module "route_table" {
  source              = "./modules/route_table"
  service_name        = local.service_full_name
  vpc_id              = module.vpc.aws_vpc_id
  igw_id              = module.igw.aws_internet_gateway_default_id
  nat_gw_id_1         = module.nat.aws_nat_gateway_nat_1_id
  nat_gw_id_2         = module.nat.aws_nat_gateway_nat_2_id
  az_1                = var.subnet_az_1
  az_2                = var.subnet_az_2
  subnet_public_az_1  = module.subnet.aws_subnet_public1_az_1a_id
  subnet_public_az_2  = module.subnet.aws_subnet_public2_az_1b_id
  subnet_private_az_1 = module.subnet.aws_subnet_private1_az_1a_id
  subnet_private_az_2 = module.subnet.aws_subnet_private2_az_1b_id

  depends_on = [
    module.vpc,
    module.igw,
    module.nat,
    module.subnet
  ]

  providers = {
    aws = aws
  }
}

# Application
module "ecs" {
  source       = "./modules/ecs"
  service_name = local.service_full_name

  providers = {
    aws = aws
  }
}

module "alb" {
  source                = "./modules/alb"
  service_name          = local.service_full_name
  alb_security_group_id = module.security_group.aws_security_group_cluster_from_internet_to_alb_id
  certificate_arn       = module.acm.aws_acm_certificate_arn
  vpc_id                = module.vpc.aws_vpc_id

  public_subnet_ids = [
    module.subnet.aws_subnet_public1_az_1a_id,
    module.subnet.aws_subnet_public2_az_1b_id
  ]

  depends_on = [
    module.vpc.aws_vpc_id,
    module.subnet,
    module.security_group,
    module.acm
  ]

  providers = {
    aws = aws
  }
}

