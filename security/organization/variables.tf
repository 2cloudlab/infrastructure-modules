# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These variables are expected to be passed in by the operator
# ---------------------------------------------------------------------------------------------------------------------

variable "aws_region" {
  description = "The AWS region in which all resources will be created"
  type        = string
}

variable "aws_account_id" {
  description = "The ID of the AWS Account in which to create resources."
  type        = string
}

variable "child_accounts" {
  description = "The child accounts to create. This is a map where the key is the name of the account and the value is the email address to use for the root user (this email must be globally unique amongst all AWS accounts!."
  type        = map(string)
}

variable "organizations_account_access_role_name" {
  description = "The name to use for the IAM role that will be created in child accounts. Users in the root account will be able to assume this role to get admin access to those child accounts."
  type        = string
  default     = "OrganizationAccountAccessRole"
}