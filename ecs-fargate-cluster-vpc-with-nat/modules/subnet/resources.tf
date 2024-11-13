resource "aws_subnet" "tfer--subnet-0141cfa4c3a5f4896" {
  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "10.0.0.0/20"
  enable_dns64                                   = "false"
  enable_lni_at_device_index                     = "0"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "false"
  private_dns_hostname_type_on_launch            = "ip-name"
  availability_zone                              = "us-east-1a"

  tags = {
    Name    = "cluster-dev-subnet-public1-us-east-1a"
    service = "cluster-dev"
  }

  tags_all = {
    Name    = "cluster-dev-subnet-public1-us-east-1a"
    service = "cluster-dev"
  }

  vpc_id = data.terraform_remote_state.vpc.outputs.aws_vpc_tfer--vpc-0f2f0fc8f728581b0_id
}

resource "aws_subnet" "tfer--subnet-0365bb50aa233f7b4" {
  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "10.0.144.0/20"
  enable_dns64                                   = "false"
  enable_lni_at_device_index                     = "0"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "false"
  private_dns_hostname_type_on_launch            = "ip-name"
  availability_zone                              = "us-east-1b"

  tags = {
    Name    = "cluster-dev-subnet-private2-us-east-1b"
    service = "cluster-dev"
  }

  tags_all = {
    Name    = "cluster-dev-subnet-private2-us-east-1b"
    service = "cluster-dev"
  }

  vpc_id = data.terraform_remote_state.vpc.outputs.aws_vpc_tfer--vpc-0f2f0fc8f728581b0_id
}

resource "aws_subnet" "tfer--subnet-0496cf678e8d69b22" {
  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "10.0.128.0/20"
  enable_dns64                                   = "false"
  enable_lni_at_device_index                     = "0"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "false"
  private_dns_hostname_type_on_launch            = "ip-name"
  availability_zone                              = "us-east-1a"

  tags = {
    Name    = "cluster-dev-subnet-private1-us-east-1a"
    service = "cluster-dev"
  }

  tags_all = {
    Name    = "cluster-dev-subnet-private1-us-east-1a"
    service = "cluster-dev"
  }

  vpc_id = data.terraform_remote_state.vpc.outputs.aws_vpc_tfer--vpc-0f2f0fc8f728581b0_id
}

resource "aws_subnet" "tfer--subnet-0a6d91f87b68a4d68" {
  assign_ipv6_address_on_creation                = "false"
  cidr_block                                     = "10.0.16.0/20"
  enable_dns64                                   = "false"
  enable_lni_at_device_index                     = "0"
  enable_resource_name_dns_a_record_on_launch    = "false"
  enable_resource_name_dns_aaaa_record_on_launch = "false"
  ipv6_native                                    = "false"
  map_customer_owned_ip_on_launch                = "false"
  map_public_ip_on_launch                        = "false"
  private_dns_hostname_type_on_launch            = "ip-name"
  availability_zone                              = "us-east-1b"

  tags = {
    Name    = "cluster-dev-subnet-public2-us-east-1b"
    service = "cluster-dev"
  }

  tags_all = {
    Name    = "cluster-dev-subnet-public2-us-east-1b"
    service = "cluster-dev"
  }

  vpc_id = data.terraform_remote_state.vpc.outputs.aws_vpc_tfer--vpc-0f2f0fc8f728581b0_id
}
