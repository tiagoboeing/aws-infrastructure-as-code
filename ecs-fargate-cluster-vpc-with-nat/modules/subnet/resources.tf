# AZ us-east-1a
resource "aws_subnet" "public1_az_1a" {
  vpc_id                                         = var.vpc_id
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.0.0.0/20"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  private_dns_hostname_type_on_launch            = "ip-name"
  availability_zone                              = "us-east-1a"

  tags = {
    name = "${var.service_name}-subnet-public1-us-east-1a"
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
  availability_zone                              = "us-east-1a"

  tags = {
    name = "${var.service_name}-subnet-private1-us-east-1a"
  }
}

# AZ us-east-1b
resource "aws_subnet" "public2_az_1b" {
  vpc_id                                         = var.vpc_id
  assign_ipv6_address_on_creation                = false
  cidr_block                                     = "10.0.16.0/20"
  enable_dns64                                   = false
  enable_resource_name_dns_a_record_on_launch    = false
  enable_resource_name_dns_aaaa_record_on_launch = false
  ipv6_native                                    = false
  private_dns_hostname_type_on_launch            = "ip-name"
  availability_zone                              = "us-east-1b"

  tags = {
    name = "${var.service_name}-subnet-public2-us-east-1b"
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
  availability_zone                              = "us-east-1b"

  tags = {
    name = "${var.service_name}-subnet-private2-us-east-1b"
  }
}
