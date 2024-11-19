output "aws_lb_cluster_alb_id" {
  value = aws_lb.cluster_alb.id
}

output "aws_lb_target_group_ecs_cluster_id" {
  value = aws_lb_target_group.ecs_cluster.id
}

output "aws_lb_listener_https_id" {
  value = aws_lb_listener.https.id
}

output "aws_lb_listener_http_id" {
  value = aws_lb_listener.http.id
}



