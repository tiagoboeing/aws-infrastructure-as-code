resource "aws_network_interface" "tfer--eni-0304ac6cf9cd604e4" {
  description        = "ELB app/dev-cluster-alb/7b21294c5800c638"
  interface_type     = "interface"
  ipv4_prefix_count  = "0"
  ipv6_address_count = "0"
  ipv6_prefix_count  = "0"
  private_ip         = "10.0.30.184"
  private_ip_list    = ["10.0.30.184"]
  private_ips        = ["10.0.30.184"]
  private_ips_count  = "0"
  security_groups    = ["sg-0d4a5613afce6a981"]
  source_dest_check  = "true"
  subnet_id          = "subnet-0a6d91f87b68a4d68"
}

resource "aws_network_interface" "tfer--eni-03d33c78a6e5f31e3" {
  description        = "Interface for NAT Gateway nat-01d9eb0955bc89480"
  interface_type     = "nat_gateway"
  ipv4_prefix_count  = "0"
  ipv6_address_count = "0"
  ipv6_prefix_count  = "0"
  private_ip         = "10.0.17.246"
  private_ip_list    = ["10.0.17.246"]
  private_ips        = ["10.0.17.246"]
  private_ips_count  = "0"
  source_dest_check  = "false"
  subnet_id          = "subnet-0a6d91f87b68a4d68"
}

resource "aws_network_interface" "tfer--eni-08b48870e9cea1508" {
  description        = "ELB app/dev-cluster-alb/7b21294c5800c638"
  interface_type     = "interface"
  ipv4_prefix_count  = "0"
  ipv6_address_count = "0"
  ipv6_prefix_count  = "0"
  private_ip         = "10.0.4.231"
  private_ip_list    = ["10.0.4.231"]
  private_ips        = ["10.0.4.231"]
  private_ips_count  = "0"
  security_groups    = ["sg-0d4a5613afce6a981"]
  source_dest_check  = "true"
  subnet_id          = "subnet-0141cfa4c3a5f4896"
}

resource "aws_network_interface" "tfer--eni-097d4eead25e79f98" {
  description        = "Interface for NAT Gateway nat-09cc1e5575fd52fce"
  interface_type     = "nat_gateway"
  ipv4_prefix_count  = "0"
  ipv6_address_count = "0"
  ipv6_prefix_count  = "0"
  private_ip         = "10.0.1.16"
  private_ip_list    = ["10.0.1.16"]
  private_ips        = ["10.0.1.16"]
  private_ips_count  = "0"
  source_dest_check  = "false"
  subnet_id          = "subnet-0141cfa4c3a5f4896"
}

resource "aws_network_interface" "tfer--eni-0ad6035fa57c0cfc9" {
  description        = "arn:aws:ecs:us-east-1:847640070182:attachment/85669da0-5353-4175-a254-b7c4ee65063d"
  interface_type     = "interface"
  ipv4_prefix_count  = "0"
  ipv6_address_count = "0"
  ipv6_prefix_count  = "0"
  private_ip         = "10.0.159.231"
  private_ip_list    = ["10.0.159.231"]
  private_ips        = ["10.0.159.231"]
  private_ips_count  = "0"
  security_groups    = ["sg-017930792a1347fcb"]
  source_dest_check  = "true"
  subnet_id          = "subnet-0365bb50aa233f7b4"
}

resource "aws_network_interface" "tfer--eni-0c1f9cca485bd867e" {
  description        = "arn:aws:ecs:us-east-1:847640070182:attachment/d379ec10-3cee-4c4c-b41a-a007aa6fe7d9"
  interface_type     = "interface"
  ipv4_prefix_count  = 0
  ipv6_address_count = 0
  ipv6_prefix_count  = 0
  private_ip         = "10.0.135.176"
  private_ip_list    = ["10.0.135.176"]
  private_ips        = ["10.0.135.176"]
  private_ips_count  = 0
  security_groups    = ["sg-017930792a1347fcb"]
  source_dest_check  = "true"
  subnet_id          = "subnet-0496cf678e8d69b22"
}
