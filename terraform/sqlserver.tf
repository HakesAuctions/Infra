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

  #database_name = "app"
  database_user = "admin"

  database_manage_master_user_password = true

  database_port     = 1433
  multi_az          = true
  storage_type      = "gp3"
  allocated_storage = 200
  storage_encrypted = true

  engine               = "sqlserver-se"
  major_engine_version = "16.00" # SQL Server 2022
  engine_version       = "16.00.4175.1.v1"
  license_model        = "license-included"

  instance_class     = "db.t3.xlarge" #TODO: Change to t3.xlarge before going live
  db_parameter_group = "sqlserver-se-16.0"

  publicly_accessible = true

  subnet_ids = module.dynamic_subnets.public_subnet_ids
  vpc_id     = module.vpc.vpc_id

  auto_minor_version_upgrade  = true
  allow_major_version_upgrade = false
  apply_immediately           = false
  maintenance_window          = "Sun:04:00-Sun:06:00"
  skip_final_snapshot         = false
  copy_tags_to_snapshot       = true
  backup_retention_period     = 7
  backup_window               = "00:00-04:00"

  # db_parameter = [
  #   { name  = "myisam_sort_buffer_size"   value = "1048576" },
  #   { name  = "sort_buffer_size"          value = "2097152" }
  # ]

  db_options = [
    {
      option_name = "SQLSERVER_BACKUP_RESTORE"
      option_settings = [
        {
          name  = "IAM_ROLE_ARN"
          value = "arn:aws:iam::206417140802:role/hakes-prd-appdb-backup" #module.appdb_backup_role.arn
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
