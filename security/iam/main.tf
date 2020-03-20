provider "aws" {
  region              = var.aws_region
  version             = "= 2.46"
  allowed_account_ids = [var.aws_account_id]
}

terraform {
  backend "s3" {}
  required_version = "= 0.12.19"
}

module "iam_across_account_assistant" {
  source = "git::git@github.com:2cloudlab.git/module_security.git//modules/iam_across_account_assistant?ref=v0.0.1"

  allow_read_only_access_from_other_account_arns = var.allow_read_only_access_from_other_account_arns
  should_require_mfa                             = var.should_require_mfa
  across_account_access_role_arns_by_group       = var.across_account_access_role_arns_by_group
  user_groups                                    = var.user_groups
}