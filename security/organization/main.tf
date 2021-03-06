provider "aws" {
  # The AWS region in which all resources will be created
  region = var.aws_region

  # Require a 2.x version of the AWS provider
  version = "= 2.46"

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = [var.aws_account_id]
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt or via a backend.hcl file. See
  # https://www.terraform.io/docs/backends/config.html#partial-configuration
  backend "s3" {}

  # Only allow this Terraform version. Note that if you upgrade to a newer version, Terraform won't allow you to use an
  # older version, so when you upgrade, you should upgrade everyone on your team and your CI servers all at once.
  required_version = "= 0.12.19"
}

resource "aws_organizations_organization" "org" {
  feature_set                   = "ALL"
  aws_service_access_principals = ["cloudtrail.amazonaws.com"]
}

resource "aws_organizations_account" "child_accounts" {
  for_each  = var.child_accounts
  name      = each.key
  email     = each.value
  role_name = var.organizations_account_access_role_name
}