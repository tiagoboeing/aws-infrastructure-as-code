resource "aws_nat_gateway" "nat_1" {
  subnet_id         = var.public_subnet_id_1
  allocation_id     = var.elastic_ip_1_allocation_id
  connectivity_type = "public"
  private_ip        = "10.0.1.16"

  tags = {
    Name = "${var.service_name}-nat-gateway-1"
  }
}

resource "aws_nat_gateway" "nat_2" {
  subnet_id         = var.public_subnet_id_2
  allocation_id     = var.elastic_ip_2_allocation_id
  connectivity_type = "public"
  private_ip        = "10.0.17.246"

  tags = {
    Name = "${var.service_name}-nat-gateway-2"
  }
}


