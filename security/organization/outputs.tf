output "child_accounts" {
  value = {
    for key, value in aws_organizations_account.child_accounts :
    key => { id : value.id, arn : value.arn }
  }
}

output "organizations_account_access_role_name" {
  value = var.organizations_account_access_role_name
}