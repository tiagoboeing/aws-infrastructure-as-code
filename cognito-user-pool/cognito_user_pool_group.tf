resource "aws_cognito_user_group" "group" {
  count = length(var.user_groups)

  user_pool_id = aws_cognito_user_pool.pool.id
  name         = lower(var.user_groups[count.index].name)
  description  = var.user_groups[count.index].description

  depends_on = [
    aws_cognito_user_pool.pool
  ]
}


