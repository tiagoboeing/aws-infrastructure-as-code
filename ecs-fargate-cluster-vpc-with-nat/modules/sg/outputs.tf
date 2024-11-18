output "aws_security_group_default_id" {
  value = aws_security_group.default.id
}

output "aws_security_group_cluster_from_internet_to_alb_id" {
  value = aws_security_group.cluster_from_internet_to_alb.id
}

output "aws_security_group_cluster_from_alb_to_ecs_id" {
  value = aws_security_group.cluster_from_alb_to_ecs.id
}
