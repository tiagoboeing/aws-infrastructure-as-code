output "apprunner_service_arn" {
  description = "ARN of the App Runner service"
  value       = var.create_apprunner_service ? aws_apprunner_service.service[0].arn : "App Runner service not created yet"
}

output "apprunner_service_name" {
  description = "Name of the App Runner service"
  value       = var.create_apprunner_service ? aws_apprunner_service.service[0].service_name : local.service_full_name
}

output "apprunner_service_id" {
  description = "ID of the App Runner service"
  value       = var.create_apprunner_service ? aws_apprunner_service.service[0].id : "App Runner service not created yet"
}

output "apprunner_service_status" {
  description = "Status of the App Runner service"
  value       = var.create_apprunner_service ? aws_apprunner_service.service[0].status : "Not created"
}

output "apprunner_service_url" {
  description = "URL of the App Runner service"
  value       = var.create_apprunner_service ? aws_apprunner_service.service[0].service_url : "App Runner service not created yet"
}

output "apprunner_auto_scaling_configuration_arn" {
  description = "ARN of the App Runner auto-scaling configuration"
  value       = aws_apprunner_auto_scaling_configuration_version.autoscalling.arn
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.registry.repository_url
}

output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.registry.arn
}

output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.registry.name
}

output "ecr_repository_id" {
  description = "ID of the ECR repository"
  value       = aws_ecr_repository.registry.id
}