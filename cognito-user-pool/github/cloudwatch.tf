resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${aws_lambda_function.function.function_name}"
  retention_in_days = 7

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Stage = var.stage
  }
}

