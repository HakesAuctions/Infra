# Disabled until account is a part of an AWS Organization
# resource "aws_organizations_policy" "deny_all_regions_except_us_east_1" {
#   name        = "DenyAllRegionsExceptUSEast1"
#   description = "Deny all AWS regions except us-east-1"
#   content     = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid      = "DenyAllRegionsExceptUSEast1"
#         Effect   = "Deny"
#         Action   = "*"
#         Resource = "*"
#         Condition = {
#           StringNotEquals = {
#             "aws:RequestedRegion" = "us-east-1"
#           }
#         }
#       }
#     ]
#   })

#   type = "SERVICE_CONTROL_POLICY"
# }

# resource "aws_organizations_policy" "deny_disabling_s3_block" {
#   name        = "DenyDisablingS3PublicAccessBlock"
#   description = "Allows enabling but denies disabling account-level S3 Block Public Access"
#   content     = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid    = "DenyDisablingS3Block"
#         Effect = "Deny"
#         Action = "s3:PutAccountPublicAccessBlock"
#         Resource = "*"
#         Condition = {
#           "StringEqualsIfExists" = {
#             "s3:PublicAccessBlockConfiguration.BlockPublicAcls"       = "false",
#             "s3:PublicAccessBlockConfiguration.IgnorePublicAcls"      = "false",
#             "s3:PublicAccessBlockConfiguration.BlockPublicPolicy"     = "false",
#             "s3:PublicAccessBlockConfiguration.RestrictPublicBuckets" = "false"
#           }
#         }
#       },
#       {
#         Sid    = "DenyDeletingS3Block"
#         Effect = "Deny"
#         Action = "s3:DeleteAccountPublicAccessBlock"
#         Resource = "*"
#       }
#     ]
#   })

#   type = "SERVICE_CONTROL_POLICY"
# }
