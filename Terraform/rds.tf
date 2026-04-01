# DB Subnet Group
resource "aws_db_subnet_group" "aws_study_db_subnet_group" {
  name = "aws-study-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1c.id
  ]

  tags = {
    Name = "aws-study-db-subnet-group"
  }
}

# RDS
resource "aws_db_instance" "aws_study_rds" {

  identifier = "aws-study-rds"

  engine         = "mysql"
  engine_version = "8.0.41"

  instance_class = "db.t4g.micro"

  allocated_storage = 20
  storage_type      = "gp2"

  db_name  = "awsstudy"
  username = var.db_user
  password = var.db_password

  port = 3306

  vpc_security_group_ids = [
    aws_security_group.rds_sg.id
  ]

  db_subnet_group_name = aws_db_subnet_group.aws_study_db_subnet_group.name

  backup_retention_period = 7

  skip_final_snapshot = true

  tags = {
    Name = "aws-study-rds"
  }
}