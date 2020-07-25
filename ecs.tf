# ECS Cluster
resource "aws_ecs_cluster" "prd" {
  name = "${var.service_name}-fgt-cluster"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "prd" {
  family                   = "${var.service_name}-fgt-task-app"
  cpu                      = "1024"
  memory                   = "2048"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions = templatefile("./ecs/container_definitions/app.json.tmpl", {
    nginx_repo             = aws_ecr_repository.nginx.repository_url,
    app_repo               = aws_ecr_repository.app.repository_url,
    db_host                = aws_db_instance.prd.address,
    db_user                = aws_db_instance.prd.username,
    redis_host             = aws_elasticache_replication_group.prd.configuration_endpoint_address,
    s3_bucket_name         = "${var.service_name}-s3-bucket",
    static_url             = "s3.ap-northeast-1.com",
  })
  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  task_role_arn      = aws_iam_role.ecs_task.arn
}

# ECS Service
resource "aws_ecs_service" "prd" {
  name                              = "${var.service_name}-fgt-service-app"
  cluster                           = aws_ecs_cluster.prd.arn
  task_definition                   = aws_ecs_task_definition.prd.arn
  desired_count                     = 1
  launch_type                       = "FARGATE"
  health_check_grace_period_seconds = 60

  network_configuration {
    security_groups = ["${aws_security_group.app.id}"]
    subnets = [
      aws_subnet.public_a.id,
      aws_subnet.public_c.id,
    ]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = "${aws_lb_target_group.prd.id}"
    container_name   = "nginx"
    container_port   = "80"
  }

  lifecycle {
    ignore_changes = [task_definition]
  }

  depends_on = [
    "aws_lb_listener.https",
  ]
}
