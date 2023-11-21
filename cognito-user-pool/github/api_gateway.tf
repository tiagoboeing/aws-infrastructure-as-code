resource "aws_apigatewayv2_api" "gateway" {
  name                       = local.function_name
  protocol_type              = "HTTP"
  route_selection_expression = "$request.method $request.path"

  tags = {
    Stage = var.stage
  }
}

resource "aws_apigatewayv2_integration" "gateway_integration" {
  api_id               = aws_apigatewayv2_api.gateway.id
  integration_type     = "AWS_PROXY"
  connection_type      = "INTERNET"
  integration_method   = "POST"
  integration_uri      = aws_lambda_function.function.invoke_arn
  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_route" "gateway_route" {
  api_id    = aws_apigatewayv2_api.gateway.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.gateway_integration.id}"
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.gateway.id
  name        = var.stage
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_logs.arn
    format = jsonencode({
      requestId : "$context.requestId",
      extendedRequestId : "$context.extendedRequestId",
      ip : "$context.identity.sourceIp",
      caller : "$context.identity.caller",
      user : "$context.identity.user",
      requestTime : "$context.requestTime",
      httpMethod : "$context.httpMethod",
      resourcePath : "$context.resourcePath",
      path : "$context.path",
      status : "$context.status",
      protocol : "$context.protocol",
      responseLength : "$context.responseLength",
      responseStatus : "$context.status",
      integrationStatus : "$context.integration.status",
    })
  }

  default_route_settings {
    logging_level            = "INFO"
    detailed_metrics_enabled = true
    throttling_burst_limit   = 500
    throttling_rate_limit    = 1000
  }
}

resource "aws_apigatewayv2_deployment" "deployment" {
  api_id      = aws_apigatewayv2_api.gateway.id
  description = "API Gateway deployment"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "api_logs" {
  name              = "/aws/apigateway/${aws_apigatewayv2_api.gateway.name}"
  retention_in_days = 7

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Stage = var.stage
  }
}
