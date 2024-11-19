resource "aws_nat_gateway" "nat_1" {
  subnet_id = var.public_subnet_id_1
  # TODO:
  allocation_id     = "eipalloc-0fc9ca9c17347d633"
  connectivity_type = "public"
  private_ip        = "10.0.1.16"

  tags_all = {
    name    = "${var.service_name}-nat-gateway-1"
    service = var.service_name
  }
}

resource "aws_nat_gateway" "nat_2" {
  subnet_id = var.public_subnet_id_2
  # TODO:
  allocation_id     = "eipalloc-02a777ef2c7ff4c79"
  connectivity_type = "public"
  private_ip        = "10.0.17.246"

  tags_all = {
    name    = "${var.service_name}-nat-gateway-2"
    service = var.service_name
  }
}


