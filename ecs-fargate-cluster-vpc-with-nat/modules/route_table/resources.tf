resource "aws_main_route_table_association" "tfer--vpc-0f2f0fc8f728581b0" {
  route_table_id = data.terraform_remote_state.route_table.outputs.aws_route_table_tfer--rtb-02116c1a2ac3bea6c_id
  vpc_id         = "vpc-0f2f0fc8f728581b0"
}

resource "aws_route_table" "tfer--rtb-02116c1a2ac3bea6c" {
  tags = {
    service = "cluster-dev"
  }

  vpc_id = "vpc-0f2f0fc8f728581b0"
}

resource "aws_route_table" "tfer--rtb-053279791c0193fe1" {
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "nat-09cc1e5575fd52fce"
  }

  tags = {
    name    = "cluster-dev-rtb-private1-us-east-1a"
    service = "cluster-dev"
  }

  vpc_id = "vpc-0f2f0fc8f728581b0"
}

resource "aws_route_table" "tfer--rtb-066cf8a8be4ffce12" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-04d91dd1a28a48fed"
  }

  tags = {
    name    = "cluster-dev-rtb-public"
    service = "cluster-dev"
  }

  vpc_id = "vpc-0f2f0fc8f728581b0"
}

resource "aws_route_table" "tfer--rtb-0baa2d9aaa9035f00" {
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "nat-01d9eb0955bc89480"
  }

  tags = {
    name    = "cluster-dev-rtb-private2-us-east-1b"
    service = "cluster-dev"
  }

  vpc_id = "vpc-0f2f0fc8f728581b0"
}

resource "aws_route_table_association" "tfer--subnet-0141cfa4c3a5f4896" {
  route_table_id = data.terraform_remote_state.route_table.outputs.aws_route_table_tfer--rtb-066cf8a8be4ffce12_id
  subnet_id      = "subnet-0141cfa4c3a5f4896"
}

resource "aws_route_table_association" "tfer--subnet-0365bb50aa233f7b4" {
  route_table_id = data.terraform_remote_state.route_table.outputs.aws_route_table_tfer--rtb-0baa2d9aaa9035f00_id
  subnet_id      = "subnet-0365bb50aa233f7b4"
}

resource "aws_route_table_association" "tfer--subnet-0496cf678e8d69b22" {
  route_table_id = data.terraform_remote_state.route_table.outputs.aws_route_table_tfer--rtb-053279791c0193fe1_id
  subnet_id      = "subnet-0496cf678e8d69b22"
}

resource "aws_route_table_association" "tfer--subnet-0a6d91f87b68a4d68" {
  route_table_id = data.terraform_remote_state.route_table.outputs.aws_route_table_tfer--rtb-066cf8a8be4ffce12_id
  subnet_id      = "subnet-0a6d91f87b68a4d68"
}
