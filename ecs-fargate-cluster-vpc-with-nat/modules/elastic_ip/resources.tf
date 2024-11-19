data "aws_region" "current" {}

resource "aws_eip" "eip_1" {
  domain               = "vpc"
  network_border_group = data.aws_region.current.name != null ? data.aws_region.current.name : "us-east-1"
  network_interface    = var.network_interface_az1_id
  public_ipv4_pool     = "amazon"

  tags = {
    name = "${var.service_name}-eip-1"
  }
}

resource "aws_eip" "eip_2" {
  domain               = "vpc"
  network_border_group = data.aws_region.current.name != null ? data.aws_region.current.name : "us-east-1"
  network_interface    = var.network_interface_az2_id
  public_ipv4_pool     = "amazon"

  tags = {
    name = "${var.service_name}-eip-2"
  }
}
