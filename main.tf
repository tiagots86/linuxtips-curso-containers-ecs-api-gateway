resource "aws_api_gateway_rest_api" "health_api" {
  name = format("%s-%s", var.project_name, var.environment)

  body = file("${path.module}/environment/${var.environment}/openapi.json")

  description = "API para calcular macros"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}