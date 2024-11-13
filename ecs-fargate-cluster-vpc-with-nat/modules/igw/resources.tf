resource "aws_internet_gateway" "tfer--igw-04d91dd1a28a48fed" {
  tags = {
    Name    = "cluster-dev-igw"
    service = "cluster-dev"
  }

  tags_all = {
    Name    = "cluster-dev-igw"
    service = "cluster-dev"
  }

  vpc_id = "${data.terraform_remote_state.vpc.outputs.aws_vpc_tfer--vpc-0f2f0fc8f728581b0_id}"
}
