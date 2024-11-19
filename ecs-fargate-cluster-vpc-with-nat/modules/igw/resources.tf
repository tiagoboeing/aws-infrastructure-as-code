resource "aws_internet_gateway" "default" {
  vpc_id = var.vpc_id

  tags_all = {
    name    = "${var.service_name}-igw-default"
    service = var.service_name
  }
}
