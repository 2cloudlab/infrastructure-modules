output "user_arns" {
  value = module.iam_users.user_arns
}

output "user_access_keys" {
  value = module.iam_users.user_access_keys
}

output "user_passwords" {
  value = module.iam_users.user_passwords
}