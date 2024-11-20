# Apply tag to main route table
resource "aws_default_route_table" "main" {
  default_route_table_id = var.default_route_table_id
  tags = {
    Name = "${var.service_name}-rtb-main"
  }
}

# Public
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "${var.service_name}-rtb-public"
  }
}

resource "aws_route_table_association" "public_association_az1" {
  route_table_id = aws_route_table.public.id
  subnet_id      = var.subnet_public_az_1
}

resource "aws_route_table_association" "public_association_az2" {
  route_table_id = aws_route_table.public.id
  subnet_id      = var.subnet_public_az_2
}

# Private 1
resource "aws_route_table" "private1" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw_id_1
  }

  tags = {
    Name = "${var.service_name}-rtb-private1-${var.az_1}"
  }
}

resource "aws_route_table_association" "private_association_az1" {
  route_table_id = aws_route_table.private1.id
  subnet_id      = var.subnet_private_az_1
}

# Private 2
resource "aws_route_table" "private2" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gw_id_2
  }

  tags = {
    Name = "${var.service_name}-rtb-private2-${var.az_2}"
  }
}

resource "aws_route_table_association" "private_association_az2" {
  route_table_id = aws_route_table.private2.id
  subnet_id      = var.subnet_private_az_2
}
