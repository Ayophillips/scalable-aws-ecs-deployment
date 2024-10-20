resource "aws_cloudwatch_log_group" "ecs_service_logs" {
  name              = "/ecs/${var.service_name}"
  retention_in_days = 7

  tags = {
    Name        = "${var.service_name}-logs"
    Environment = "production"
  }
}
