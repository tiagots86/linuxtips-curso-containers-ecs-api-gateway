resource "aws_cloudwatch_log_group" "health-api" {
  name = "/aws/api-gateway/${var.project_name}/${var.environment}"

  retention_in_days = 1

}