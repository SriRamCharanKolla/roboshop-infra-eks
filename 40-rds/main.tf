module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.project}-${var.environment}"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20

  db_name  = "cities"
  username = "root"
  port     = "3306"
  manage_master_user_password = false
  password_wo = "RoboShop#123"
  password_wo_version = 1

  vpc_security_group_ids = [local.mysql_sg_id]

  # DB subnet group
  create_db_subnet_group = false
  db_subnet_group_name = local.database_subnet_group_name

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection & Snapshot Governance:
  # In Dev/Sandbox: Set `deletion_protection = false` and `skip_final_snapshot = true`
  # to allow rapid teardowns and prevent AWS naming collision errors (`DBSnapshotAlreadyExists`).
  # In Production: Set `deletion_protection = true` and `skip_final_snapshot = false`
  # with a dynamic timestamped identifier:
  # `final_snapshot_identifier = "${var.project}-${var.environment}-final-${formatdate("YYYY-MM-DD-hh-mm-ss", timestamp())}"`
  deletion_protection = false
  skip_final_snapshot = true


  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-mysql"
    }
  )
}