resource "aws_security_group" "default" {
  vpc_id      = var.vpc_id
  name        = "${var.service_name}-sg-default"
  description = "Default VPC security group"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    self        = "false"
    to_port     = 0
  }

  ingress {
    from_port = 0
    protocol  = "-1"
    self      = "true"
    to_port   = 0
  }
}

resource "aws_security_group" "cluster_from_internet_to_alb" {
  vpc_id      = var.vpc_id
  name        = "${var.service_name}-sg-from-internet-to-alb"
  description = "Allow incoming traffic from internet to the ALB"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    self        = "false"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    self        = "false"
    to_port     = 443
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    self        = "false"
    to_port     = 80
  }

  # Application port
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3000
    protocol    = "tcp"
    self        = "false"
    to_port     = 3000
  }

  tags_all = {
    Name    = "Allow incoming traffic from internet to the ALB"
    service = var.service_name
  }
}

resource "aws_security_group" "cluster_from_alb_to_ecs" {
  vpc_id      = var.vpc_id
  name        = "${var.service_name}-sg-from-alb-to-ecs"
  description = "Traffic from ALB to ECS"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    self        = "false"
    to_port     = 0
  }

  ingress {
    from_port       = 0
    protocol        = "-1"
    security_groups = [aws_security_group.cluster_from_internet_to_alb.id]
    self            = "false"
    to_port         = 0
  }

  tags_all = {
    Name    = "Traffic from ALB to ECS"
    service = var.service_name
  }
}
