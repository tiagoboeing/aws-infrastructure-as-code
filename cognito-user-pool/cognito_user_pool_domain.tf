resource "random_string" "hash" {
  length  = 6
  special = false
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = join("-", [aws_cognito_user_pool.pool.name, lower(random_string.hash.result)])
  user_pool_id = aws_cognito_user_pool.pool.id
}
