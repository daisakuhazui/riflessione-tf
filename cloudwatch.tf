resource "aws_cloudwatch_log_group" "stg" {
  name              = "/ecs/riflessione"
  retention_in_days = 180
}
