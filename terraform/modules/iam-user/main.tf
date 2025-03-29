resource "aws_iam_user" "this" {
  # checkov:skip=CKV_AWS_273
  name = var.name
}

resource "aws_iam_user_group_membership" "this" {
  user = aws_iam_user.this.name

  groups = var.groups
}
