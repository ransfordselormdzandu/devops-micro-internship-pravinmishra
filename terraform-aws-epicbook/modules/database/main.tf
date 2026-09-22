resource "aws_db_subnet_group" "epicbook" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [var.private_db_subnet_a_id, var.private_db_subnet_b_id]

  tags = {
    Name    = "${var.project_name}-db-subnet-group"
    Project = var.project_name
  }
}

resource "aws_db_instance" "epicbook" {
  identifier     = "${var.project_name}-db"
  engine         = "mysql"
  engine_version = var.engine_version
  instance_class = var.db_instance_class

  allocated_storage = var.allocated_storage

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.epicbook.name
  vpc_security_group_ids = [var.rds_security_group_id]

  publicly_accessible = false
  skip_final_snapshot = true

  tags = {
    Name    = "${var.project_name}-db"
    Project = var.project_name
  }
}