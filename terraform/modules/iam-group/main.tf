resource "aws_iam_group" "this" {
  name = var.name
}

resource "aws_iam_group_policy_attachment" "this" {
  for_each = toset(var.policy_arns)

  group      = aws_iam_group.this.name
  policy_arn = each.value
}
