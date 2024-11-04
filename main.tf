resource "aws_api_gateway_rest_api" "health_api" {
  name = format("%s-%s", var.project_name, var.environment)

  body = file("${path.module}/environment/${var.environment}/openapi.json")

  description = "API para calcular macros"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "health_api" {
  rest_api_id = aws_api_gateway_rest_api.health_api.id

  triggers = {
    redeploy = sha256(jsonencode(aws_api_gateway_rest_api.health_api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "health_api" {
  deployment_id = aws_api_gateway_deployment.health_api.id
  rest_api_id   = aws_api_gateway_rest_api.health_api.id
  stage_name    = var.environment

  variables = {
    vpcLinkId = data.aws_ssm_parameter.vpc_link.value
  }

}