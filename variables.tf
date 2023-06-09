data "aws_caller_identity" "current" {}

locals {
  s3_bucket_name = "${data.aws_caller_identity.current.account_id}-public-website"
}