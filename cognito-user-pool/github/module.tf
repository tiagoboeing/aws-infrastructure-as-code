variable "github_credentials" {
  description = "GitHub OAuth settings"
  type        = map(string)
  default     = {}
}

variable "pool_name" {
  description = "Cognito user pool name"
  type        = string
}

variable "function_name" {
  description = "Lambda function name"
  type        = string
  default     = "cognito-github-proxy"
}

locals {
  function_name = join("-", [var.pool_name, var.function_name])
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "index.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "function" {
  filename      = "lambda_function_payload.zip"
  function_name = local.function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.py"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"

  environment {
    variables = {}
  }
}
