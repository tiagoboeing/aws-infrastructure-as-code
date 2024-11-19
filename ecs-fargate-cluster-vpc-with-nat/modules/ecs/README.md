# ECS Cluster

This module creates an ECS cluster and namespace. Service and task definition are not included because it depends on each application type.

> [!NOTE]
> **The cluster module only creates the ECS cluster and namespace.**
> 
> Optionally, it can also create the service and the task definition, you can use the code blocks below as a reference to implement it.

## Task definition 

```tf
resource "aws_ecs_task_definition" "my-app" {
  cpu                      = "256"
  execution_role_arn       = "arn:aws:iam::<account-id>:role/ecsTaskExecutionRole"
  family                   = "<task-definition-family>"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  task_role_arn = "arn:aws:iam::<account-id>:role/ecsTaskExecutionRole"
  track_latest  = "false"

  container_definitions = <<DEFINITION
  [
    {
      "name": "<container-name>",
      "image": "<image-url>",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 3000,
          "hostPort": 3000
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/<log-group-name>",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
  DEFINITION
}
```

## Service

```tf
resource "aws_ecs_service" "my-app" {
  name    = var.app_name
  cluster = var.service_name

  platform_version                   = "LATEST"
  scheduling_strategy                = "REPLICA"
  task_definition                    = "<task-definition-arn>"
  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "100"
  desired_count                      = "1"
  enable_ecs_managed_tags            = "true"
  enable_execute_command             = "false"
  health_check_grace_period_seconds  = "30"

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

  deployment_circuit_breaker {
    enable   = "true"
    rollback = "false"
  }

  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    container_name   = "<container-name>"
    container_port   = "3000"
    target_group_arn = "<target-group-arn>"
  }

  # TODO:
  network_configuration {
    assign_public_ip = "true"
    security_groups  = [...]
    subnets          = [...]
  }
}
```