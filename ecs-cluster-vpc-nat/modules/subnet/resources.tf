# AZ 1
resource "aws_subnet" "public1_az_1a" {
  vpc_id                                         = var.vpc_id
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.0.0.0/20"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  private_dns_hostname_type_on_launch            = "ip-name"
  availability_zone                              = var.az_1

  tags = {
    Name = "${var.service_name}-subnet-public1-${var.az_1}"
  }
}

resource "aws_subnet" "private1_az_1a" {
  vpc_id                                         = var.vpc_id
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.0.128.0/20"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  private_dns_hostname_type_on_launch            = "ip-name"
  availability_zone                              = var.az_1

  tags = {
    Name = "${var.service_name}-subnet-private1-${var.az_1}"
  }
}

# AZ 2
resource "aws_subnet" "public2_az_1b" {
  vpc_id                                         = var.vpc_id
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.0.16.0/20"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  private_dns_hostname_type_on_launch            = "ip-name"
  availability_zone                              = var.az_2

  tags = {
    Name = "${var.service_name}-subnet-public2-${var.az_2}"
  }
}

resource "aws_subnet" "private2_az_1b" {
  vpc_id                                         = var.vpc_id
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.0.144.0/20"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  private_dns_hostname_type_on_launch            = "ip-name"
  availability_zone                              = var.az_2

  tags = {
    Name = "${var.service_name}-subnet-private2-${var.az_2}"
  }
}
