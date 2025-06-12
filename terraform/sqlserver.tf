module "sqlserver" {
  source  = "cloudposse/rds/aws"
  version = "v1.1.2"

  namespace = local.namespace
  stage     = terraform.workspace
  name      = "appdb"

  dns_zone_id = aws_route53_zone.hakes_com.zone_id
  host_name   = "db"

  security_group_ids = concat(
    [for v in module.app_ec2 : v.security_group_id],
    [for v in module.backend_ec2 : v.security_group_id]
  )

  ca_cert_identifier  = "rds-ca-rsa2048-g1"
  allowed_cidr_blocks = local.whitelist_cidrs

  database_user = "admin"

  database_manage_master_user_password = true

  database_port         = 1433
  multi_az              = true
  storage_type          = "gp3"
  allocated_storage     = 200
  max_allocated_storage = 500
  storage_encrypted     = true

  instance_class = "db.t3.2xlarge" # Hope to scale down the db
  license_model  = "license-included"

  engine = "sqlserver-se"

  major_engine_version = "13.00" # SQL Server 2016
  engine_version       = "13.00.6455.2.v1"
  db_parameter_group   = "sqlserver-se-13.0"

  publicly_accessible = true

  subnet_ids = module.dynamic_subnets.public_subnet_ids
  vpc_id     = module.vpc.vpc_id

  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = false
  apply_immediately           = true
  maintenance_window          = "Sun:06:00-Sun:08:00" #UTC
  skip_final_snapshot         = false
  copy_tags_to_snapshot       = true
  backup_retention_period     = 30
  backup_window               = "08:00-10:00" #UTC
  deletion_protection         = true

  # Enhanced Monitoring
  monitoring_role_arn = aws_iam_role.rds_enhanced_monitoring.arn
  # The interval, in seconds, between points when Enhanced Monitoring metrics
  # are collected for the DB instance. To disable collecting Enhanced Monitoring
  # metrics, specify 0. Valid Values are 0, 1, 5, 10, 15, 30, 60.
  monitoring_interval = 60

  performance_insights_enabled = true

  db_parameter = [
    {
      name         = "clr enabled"
      value        = "1" # Enabled
      apply_method = "immediate"
    }
  ]

  db_options = [
    {
      option_name = "SQLSERVER_BACKUP_RESTORE"
      option_settings = [
        {
          name  = "IAM_ROLE_ARN"
          value = "arn:aws:iam::206417140802:role/hakes-prd-appdb-backup" # arn from module.appdb_backup_role.arn
        }
      ]

      # Empty vars, only added to make module work
      db_security_group_memberships  = []
      vpc_security_group_memberships = []
      port                           = 0
      version                        = ""
    }
  ]

  timeouts = {
    create = "90m"
    delete = "90m"
    update = "90m"
  }
}

resource "aws_iam_role" "rds_enhanced_monitoring" {
  name_prefix        = "rds-enhanced-monitoring-"
  assume_role_policy = data.aws_iam_policy_document.rds_enhanced_monitoring.json
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = aws_iam_role.rds_enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

data "aws_iam_policy_document" "rds_enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}
