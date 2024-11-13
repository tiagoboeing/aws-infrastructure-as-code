resource "aws_security_group" "tfer--default_sg-081dec66d10aa80e3" {
  description = "default VPC security group"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    from_port = "0"
    protocol  = "-1"
    self      = "true"
    to_port   = "0"
  }

  name   = "default"
  vpc_id = "vpc-0f2f0fc8f728581b0"
}

resource "aws_security_group" "tfer--dev-cluster-sg_sg-0d4a5613afce6a981" {
  description = "Allow access from internet"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "3000"
    protocol    = "tcp"
    self        = "false"
    to_port     = "3000"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "443"
    protocol    = "tcp"
    self        = "false"
    to_port     = "443"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    protocol    = "tcp"
    self        = "false"
    to_port     = "80"
  }

  name = "dev-cluster-sg"

  tags = {
    Name    = "Traffic from internet"
    service = "cluster-dev"
  }

  tags_all = {
    Name    = "Traffic from internet"
    service = "cluster-dev"
  }

  vpc_id = "vpc-0f2f0fc8f728581b0"
}

resource "aws_security_group" "tfer--ecs-sports-api_sg-017930792a1347fcb" {
  description = "Created in ECS Console"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  ingress {
    from_port       = "0"
    protocol        = "-1"
    security_groups = ["${data.terraform_remote_state.sg.outputs.aws_security_group_tfer--dev-cluster-sg_sg-0d4a5613afce6a981_id}"]
    self            = "false"
    to_port         = "0"
  }

  name = "ecs-sports-api"

  tags = {
    Name    = "Traffic from ALB to app"
    service = "cluster-dev"
  }

  tags_all = {
    Name    = "Traffic from ALB to app"
    service = "cluster-dev"
  }

  vpc_id = "vpc-0f2f0fc8f728581b0"
}
