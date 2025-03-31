locals {
  aws_id       = data.aws_caller_identity.current.account_id
  namespace    = "hakes"
  name_postfix = "eele"

  windows_server_ami = "ami-0c765d44cf1f25d26"
}
