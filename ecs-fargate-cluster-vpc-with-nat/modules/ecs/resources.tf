resource "aws_ecs_cluster" "tfer--DevCluster" {
  name = "DevCluster"

  service_connect_defaults {
    namespace = "arn:aws:servicediscovery:us-east-1:847640070182:namespace/ns-64q3q33izliijjfl"
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    service = "cluster-dev"
  }

  tags_all = {
    service = "cluster-dev"
  }
}

resource "aws_ecs_service" "tfer--DevCluster_sports-api" {
  alarms {
    alarm_names = []
    enable      = "false"
    rollback    = "false"
  }

  capacity_provider_strategy {
    base              = "0"
    capacity_provider = "FARGATE"
    weight            = "30"
  }

  capacity_provider_strategy {
    base              = "0"
    capacity_provider = "FARGATE_SPOT"
    weight            = "70"
  }

  cluster = "DevCluster"

  deployment_circuit_breaker {
    enable   = "true"
    rollback = "false"
  }

  deployment_controller {
    type = "ECS"
  }

  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "100"
  desired_count                      = "1"
  enable_ecs_managed_tags            = "true"
  enable_execute_command             = "false"
  health_check_grace_period_seconds  = "30"

  load_balancer {
    container_name   = "sports-api"
    container_port   = "3000"
    target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:847640070182:targetgroup/dev-cluster-tg/d1e1bd847f566150"
  }

  name = "sports-api"

  network_configuration {
    assign_public_ip = "true"
    security_groups  = ["${data.terraform_remote_state.sg.outputs.aws_security_group_tfer--ecs-sports-api_sg-017930792a1347fcb_id}"]
    subnets          = ["${data.terraform_remote_state.subnet.outputs.aws_subnet_tfer--subnet-0365bb50aa233f7b4_id}", "${data.terraform_remote_state.subnet.outputs.aws_subnet_tfer--subnet-0496cf678e8d69b22_id}"]
  }

  platform_version    = "LATEST"
  scheduling_strategy = "REPLICA"
  task_definition     = "arn:aws:ecs:us-east-1:847640070182:task-definition/sports-api:13"
}

resource "aws_ecs_task_definition" "tfer--task-definition-002F-resume-dev" {
  container_definitions    = ""
  cpu                      = "256"
  execution_role_arn       = "arn:aws:iam::847640070182:role/ecsTaskExecutionRole"
  family                   = "resume-dev"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  task_role_arn = "arn:aws:iam::847640070182:role/ecsTaskExecutionRole"
  track_latest  = "false"
}

resource "aws_ecs_task_definition" "tfer--task-definition-002F-sports-api" {
  container_definitions    = ""
  cpu                      = "256"
  execution_role_arn       = "arn:aws:iam::847640070182:role/ecsTaskExecutionRole"
  family                   = "sports-api"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  task_role_arn = "arn:aws:iam::847640070182:role/ecsTaskExecutionRole"
  track_latest  = "false"
}
