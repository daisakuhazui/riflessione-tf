resource "aws_elasticache_subnet_group" "prd" {
  name = "${var.service_name}-ec-sbg"
  subnet_ids = [
    "${aws_subnet.public_a.id}",
    "${aws_subnet.public_c.id}",
  ]
}

resource "aws_elasticache_replication_group" "prd" {
  replication_group_id          = "${var.service_name}-ec-cluster"
  replication_group_description = "Redis cluster for ElastiCache"

  node_type            = "cache.t2.micro"
  port                 = 6379
  parameter_group_name = "default.redis5.0.cluster.on"

  snapshot_retention_limit = 7
  snapshot_window          = "18:00-19:00"

  subnet_group_name          = "${aws_elasticache_subnet_group.prd.name}"
  automatic_failover_enabled = true

  security_group_ids = [
    aws_security_group.ec.id,
  ]

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 1
  }
}
