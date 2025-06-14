module "appdb_backup_s3" {
  source  = "cloudposse/s3-bucket/aws"
  version = "4.10.0"

  name      = "appdb-backup"
  stage     = terraform.workspace
  namespace = local.namespace

  s3_object_ownership = "BucketOwnerEnforced"
  user_enabled        = false
  versioning_enabled  = true
}

data "aws_iam_policy_document" "appdb_backup" {
  statement {
    sid    = "FullAccess"
    effect = "Allow"
    resources = [
      module.appdb_backup_s3.bucket_arn,
      "${module.appdb_backup_s3.bucket_arn}/*",
    ]

    actions = [
      "s3:ListBucket",
      "s3:GetBucketLocation",
      "s3:GetObjectAttributes",
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListMultipartUploadParts",
      "s3:AbortMultipartUpload",
    ]
  }
}

module "appdb_backup_role" {
  source  = "cloudposse/iam-role/aws"
  version = "0.21.0"

  namespace = local.namespace
  stage     = terraform.workspace
  name      = "appdb-backup"

  policy_description = "Allow access to S3 bucket for appdb backup"
  role_description   = "IAM role with permissions to perform db backups and restores"

  principals = {
    Service = ["rds.amazonaws.com"]
  }

  assume_role_conditions = [
    {
      "test"     = "StringEquals",
      "variable" = "aws:SourceArn",
      "values" = [
        module.sqlserver.instance_arn,
        "arn:aws:rds:us-east-1:${local.account_id}:og:${module.sqlserver.option_group_id}",
        module.appdb_backup_s3.bucket_arn,
      ],
    },
    {
      "test"     = "StringEquals",
      "variable" = "aws:SourceAccount",
      "values" = [
        local.account_id
      ],
    },
  ]

  policy_documents = [
    data.aws_iam_policy_document.appdb_backup.json
  ]
}
