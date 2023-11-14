output "aws_cognito_user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}

output "aws_cognito_user_pool_domain" {
  value = aws_cognito_user_pool.pool.domain
}



# Clients
output "aws_cognito_user_pool_client_api_id" {
  value = aws_cognito_user_pool_client.api.id
}

output "aws_cognito_user_pool_client_api_secret" {
  value     = aws_cognito_user_pool_client.api.client_secret
  sensitive = true
}
