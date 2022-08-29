module "db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 3.0"

  name           = "aurora-demodb-postgres"
  engine         = "aurora-postgresql"
  engine_version = "11.9"
  engine_mode    = "serverless"

  vpc_id                 = data.aws_vpc.selected.id
  vpc_security_group_ids = [data.aws_security_group.a.id]
  subnets                = [data.aws_subnet.a.id, data.aws_subnet.b.id]

  allowed_security_groups = [data.aws_security_group.a.id]

  replica_scale_enabled = false
  replica_count         = 0

  storage_encrypted = true
  apply_immediately = true
  # 0 is used to disable enhanced monitoring
  monitoring_interval = 0
  # Remove this to save a final snapshot before database is destroyed
  skip_final_snapshot  = false
  enable_http_endpoint = true

  scaling_configuration = {
    auto_pause               = true
    min_capacity             = 2
    max_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }

  # Assign credential retrieved from Vault to sysadmin
  create_random_password = false
  username               = var.db_username
  password               = data.vault_generic_secret.dbsecrets_auth.data["${var.secret_keys[0]}"]
  database_name          = var.db_name

  tags = {
    "managed-by" = "terraform"
  }

}

# provider "postgresql" {
#   #host            = "${data.aws_rds_cluster.database.endpoint}"
#   #port            = "${data.aws_rds_cluster.database.port}"
#   database        = var.db_name
#   username        = var.db_schema
#   password        = data.vault_generic_secret.dbsecrets_auth.data["${var.secret_keys[1]}"]
#   #sslmode         = "require"
#   connect_timeout = 15
# }
