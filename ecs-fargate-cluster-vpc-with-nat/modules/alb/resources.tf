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

  tags = {
    name = "${var.service_name}-alb"
  }
}

# Target group
resource "aws_lb_target_group" "ecs_cluster" {
  vpc_id                            = var.vpc_id
  name                              = "${var.service_name}-tg"
  port                              = "80"
  protocol                          = "HTTP"
  protocol_version                  = "HTTP1"
  target_type                       = "ip"
  ip_address_type                   = "ipv4"
  load_balancing_algorithm_type     = "round_robin"
  load_balancing_anomaly_mitigation = "off"
  load_balancing_cross_zone_enabled = "use_load_balancer_configuration"
  slow_start                        = "0"
  deregistration_delay              = "300"

  health_check {
    enabled             = "true"
    healthy_threshold   = "5"
    interval            = "60"
    matcher             = "200-299"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "10"
    unhealthy_threshold = "2"
  }

  stickiness {
    cookie_duration = "86400"
    enabled         = "false"
    type            = "lb_cookie"
  }

  target_group_health {
    dns_failover {
      minimum_healthy_targets_count      = "1"
      minimum_healthy_targets_percentage = "off"
    }

    unhealthy_state_routing {
      minimum_healthy_targets_count      = "1"
      minimum_healthy_targets_percentage = "off"
    }
  }


  tags = {
    name = "${var.service_name}-tg"
  }
}


# Listener
resource "aws_lb_listener" "https" {
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn
  load_balancer_arn = aws_lb.cluster_alb.arn

  default_action {
    order            = "1"
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_cluster.arn

    forward {
      stickiness {
        duration = "3600"
        enabled  = "false"
      }

      target_group {
        arn    = aws_lb_target_group.ecs_cluster.arn
        weight = "1"
      }
    }
  }

  mutual_authentication {
    ignore_client_certificate_expiry = "false"
    mode                             = "off"
  }

  tags = {
    name = "${var.service_name}-lb-listener-https"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.cluster_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    order = "1"
    type  = "redirect"

    redirect {
      host        = "#{host}"
      path        = "/#{path}"
      port        = "#{port}"
      protocol    = "HTTPS"
      query       = "#{query}"
      status_code = "HTTP_301"
    }
  }

  tags = {
    name = "${var.service_name}-lb-listener-http"
  }
}
