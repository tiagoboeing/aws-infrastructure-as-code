data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "github/code"
  output_path = "github/lambda_function_payload.zip"
}

resource "aws_lambda_function" "function" {
  filename         = "github/lambda_function_payload.zip"
  function_name    = local.function_name
  role             = aws_iam_role.role.arn
  handler          = "index.handler"
  memory_size      = 512
  timeout          = 30
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "nodejs18.x"

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {}
  }

  tags = {
    Stage = var.stage
  }
}

# resource "aws_lambda_permission" "allow_api" {
#   statement_id  = "AllowAPIgatewayInvokation"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.function.invoke_arn
#   principal     = "apigateway.amazonaws.com"

#   depends_on = [aws_lambda_function.function]
# }
