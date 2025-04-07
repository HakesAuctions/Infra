resource "aws_s3_account_public_access_block" "block_public_access" {
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
