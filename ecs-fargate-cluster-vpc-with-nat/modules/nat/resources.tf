resource "aws_nat_gateway" "tfer--nat-01d9eb0955bc89480" {
  allocation_id                      = "eipalloc-02a777ef2c7ff4c79"
  connectivity_type                  = "public"
  private_ip                         = "10.0.17.246"
  secondary_private_ip_address_count = "0"
  subnet_id                          = "subnet-0a6d91f87b68a4d68"

  tags = {
    Name    = "cluster-dev-nat-gateway-2"
    service = "cluster-dev"
  }

  tags_all = {
    Name    = "cluster-dev-nat-gateway-2"
    service = "cluster-dev"
  }
}

resource "aws_nat_gateway" "tfer--nat-09cc1e5575fd52fce" {
  allocation_id                      = "eipalloc-0fc9ca9c17347d633"
  connectivity_type                  = "public"
  private_ip                         = "10.0.1.16"
  secondary_private_ip_address_count = "0"
  subnet_id                          = "subnet-0141cfa4c3a5f4896"

  tags = {
    Name    = "cluster-dev-nat-gateway-1"
    service = "cluster-dev"
  }

  tags_all = {
    Name    = "cluster-dev-nat-gateway-1"
    service = "cluster-dev"
  }
}
