output "arn" {
  description = "The ARN of the Group"
  value       = aws_iam_group.this.arn
}

output "name" {
  description = "The Name of the Group"
  value       = aws_iam_group.this.name
}
