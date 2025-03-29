# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "tfstate_backend" {
  # checkov:skip=CKV_AWS_119
  source  = "cloudposse/tfstate-backend/aws"
  version = "1.5.0"

  namespace  = "hakes"
  stage      = terraform.workspace
  name       = "terraform"
  profile    = "hakes-admin"
  attributes = ["state"]

  terraform_state_file = "tfstate-backend.tfstate"

  force_destroy = false
}
