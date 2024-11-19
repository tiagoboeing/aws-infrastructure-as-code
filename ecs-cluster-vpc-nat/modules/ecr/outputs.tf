output "aws_ecr_repository_id" {
  value = aws_ecr_repository.repository.id
}

output "aws_ecr_repository_arn" {
  value = aws_ecr_repository.repository.arn
}

output "aws_ecr_repository_url" {
  value = aws_ecr_repository.repository.repository_url
}

output "aws_ecr_repository_registry_id" {
  value = aws_ecr_repository.repository.registry_id
}
