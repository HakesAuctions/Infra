# hakes-infra

This repo holds the IaC for Hakes aws account (206417140802)


# Enviroments
* dev (not in use)
* stg (not in use)
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
* Whitelist Office

# Route53
* hakes.com

# Alerts
* ec2 (TODO)
* rds (TODO)
* billing (TODO)
