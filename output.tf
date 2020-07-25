output "ecr_nginx_repository" {
  value = aws_ecr_repository.nginx.repository_url
}

output "ecr_app_repository" {
  value = aws_ecr_repository.app.repository_url
}

output "prd_elasticache_endpoint" {
  value = "${aws_elasticache_replication_group.prd.configuration_endpoint_address}"
}
