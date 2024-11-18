# ALB
resource "aws_lb" "cluster_alb" {
  name                                        = "${var.service_name}-alb"
  load_balancer_type                          = "application"
  client_keep_alive                           = "3600"
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = "60"
  internal                                    = false
  ip_address_type                             = "ipv4"
  preserve_host_header                        = false
  xff_header_processing_mode                  = "append"

  security_groups = [
    var.alb_security_group_id
  ]

  subnets = var.public_subnet_ids

  dynamic "subnet_mapping" {
    for_each = var.public_subnet_ids
    content {
      subnet_id = subnet_mapping.value
    }
  }

  tags_all = {
    service = var.service_name
  }
}

# Listener
# resource "aws_lb_listener" "tfer--arn-003A-aws-003A-elasticloadbalancing-003A-us-east-1-003A-847640070182-003A-listener-002F-app-002F-dev-cluster-alb-002F-7b21294c5800c638-002F-6b8400842213cab1" {
#   default_action {
#     order = "1"

#     redirect {
#       host        = "#{host}"
#       path        = "/#{path}"
#       port        = "#{port}"
#       protocol    = "HTTPS"
#       query       = "#{query}"
#       status_code = "HTTP_301"
#     }

#     type = "redirect"
#   }

#   load_balancer_arn = data.terraform_remote_state.alb.outputs.aws_lb_tfer--dev-cluster-alb_id
#   port              = "80"
#   protocol          = "HTTP"
# }

# resource "aws_lb_listener" "tfer--arn-003A-aws-003A-elasticloadbalancing-003A-us-east-1-003A-847640070182-003A-listener-002F-app-002F-dev-cluster-alb-002F-7b21294c5800c638-002F-bcf6ff67b07bc8c2" {
#   certificate_arn = "arn:aws:acm:us-east-1:847640070182:certificate/af384c67-3f26-41c7-857e-dea850a07b4d"

#   default_action {
#     forward {
#       stickiness {
#         duration = "3600"
#         enabled  = "false"
#       }

#       target_group {
#         arn    = "arn:aws:elasticloadbalancing:us-east-1:847640070182:targetgroup/dev-cluster-tg/d1e1bd847f566150"
#         weight = "1"
#       }
#     }

#     order            = "1"
#     target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:847640070182:targetgroup/dev-cluster-tg/d1e1bd847f566150"
#     type             = "forward"
#   }

#   load_balancer_arn = data.terraform_remote_state.alb.outputs.aws_lb_tfer--dev-cluster-alb_id

#   mutual_authentication {
#     ignore_client_certificate_expiry = "false"
#     mode                             = "off"
#   }

#   port       = "443"
#   protocol   = "HTTPS"
#   ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
# }

# # Target group
# resource "aws_lb_target_group" "tfer--dev-cluster-tg" {
#   deregistration_delay = "300"

#   health_check {
#     enabled             = "true"
#     healthy_threshold   = "5"
#     interval            = "60"
#     matcher             = "200-299"
#     path                = "/health"
#     port                = "traffic-port"
#     protocol            = "HTTP"
#     timeout             = "10"
#     unhealthy_threshold = "2"
#   }

#   ip_address_type                   = "ipv4"
#   load_balancing_algorithm_type     = "round_robin"
#   load_balancing_anomaly_mitigation = "off"
#   load_balancing_cross_zone_enabled = "use_load_balancer_configuration"
#   name                              = "dev-cluster-tg"
#   port                              = "80"
#   protocol                          = "HTTP"
#   protocol_version                  = "HTTP1"
#   slow_start                        = "0"

#   stickiness {
#     cookie_duration = "86400"
#     enabled         = "false"
#     type            = "lb_cookie"
#   }

#   tags = {
#     service = "cluster-dev"
#   }

#   tags_all = {
#     service = "cluster-dev"
#   }

#   target_group_health {
#     dns_failover {
#       minimum_healthy_targets_count      = "1"
#       minimum_healthy_targets_percentage = "off"
#     }

#     unhealthy_state_routing {
#       minimum_healthy_targets_count      = "1"
#       minimum_healthy_targets_percentage = "off"
#     }
#   }

#   target_type = "ip"
#   vpc_id      = "vpc-0f2f0fc8f728581b0"
# }
