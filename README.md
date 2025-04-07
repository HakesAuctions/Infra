# hakes-infra

This repo holds the IaC for Hakes aws account (206417140802)


# Enviroments
* prd

# Permission Sets/Groups
* admin
* support
* billing
* readonly

# Managed Polices
* IAM MFA (TODO)

# Load Balancer
* main load balancer

# EC2 Instances
* 2x main website
* 1x Office website & backend services

# SQLServer
* Main SQL Server
  * HakesAppDB
  * NewsManagerDB
* s3 db backup bucket

# Security Group
* EC2/RDS Whitelist
* LB Security Group

# Route53
* hakes.com

# S3
* Terrafoirm state bucket
* Database backup/restore bucket
* Block Public Access

# SCP
* Region Use Limit (disabled)
* Block disabling s3 public access (disabled)

# Alerts
* ec2 (TODO)
* rds (TODO)
* billing (TODO)
