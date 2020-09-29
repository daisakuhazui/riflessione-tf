resource "aws_db_subnet_group" "prd" {
  name       = "${var.service_name}-sbg"
  subnet_ids = ["${aws_subnet.private_a.id}", "${aws_subnet.private_c.id}"]

  tags = {
    Name = "${var.service_name}-sbg"
  }
}

resource "aws_db_parameter_group" "prd" {
  name   = "${var.service_name}-rds-parameter-group"
  family = "postgres11"

  tags = {
    Name = "${var.service_name}-rds-parameter-group"
  }
}

resource "aws_db_instance" "prd" {
  identifier              = "${var.service_name}-rds-app-01"
  engine                  = "postgres"
  engine_version          = "11.4"
  allocated_storage       = var.db_storage_size
  instance_class          = var.db_instance_class
  vpc_security_group_ids  = ["${aws_security_group.rds.id}"]
  name                    = var.db_name
  username                = var.db_admin
  password                = var.db_admin_pass
  parameter_group_name    = aws_db_parameter_group.prd.id
  db_subnet_group_name    = aws_db_subnet_group.prd.id
  backup_retention_period = "7"
  backup_window           = "17:30-18:20"
  storage_type            = "gp2"
  maintenance_window      = "Sat:18:30-Sat:19:00"
  multi_az                = false
  apply_immediately       = true
  publicly_accessible     = false
  skip_final_snapshot     = true

  tags = {
    Name = "${var.service_name}-rds-app-01",
  }

  lifecycle {
    ignore_changes = [password]
  }
}
