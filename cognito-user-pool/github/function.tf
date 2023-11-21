data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = "github/code"
  output_path = "github/lambda_function_payload.zip"
}

resource "aws_lambda_function" "function" {
  filename      = "github/lambda_function_payload.zip"
  function_name = local.function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  memory_size   = 512
  timeout       = 30

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "nodejs18.x"

  environment {
    variables = {}
  }

  tags = {
    Stage = var.stage
  }
}
