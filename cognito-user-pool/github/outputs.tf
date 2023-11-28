
output "github_api_gateway_endpoint" {
  value       = aws_apigatewayv2_api.gateway.api_endpoint
  description = "API gateway endpoint"
}
