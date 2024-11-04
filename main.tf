resource "aws_api_gateway_rest_api" "health_api" {
    name = format("%s-%s", var.project_name, var.environment)

    description = "API para calcular macros"

    endpoint_configuration {
      types = ["REGIONAL"]
    }
}