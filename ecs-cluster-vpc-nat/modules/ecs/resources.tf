# Namespace
resource "aws_service_discovery_http_namespace" "main" {
  name        = var.service_name
  description = "Main namespace for ${var.service_name}"
}

# Cluster
resource "aws_ecs_cluster" "cluster" {
  name = var.service_name

  service_connect_defaults {
    namespace = aws_service_discovery_http_namespace.main.arn
  }

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}
