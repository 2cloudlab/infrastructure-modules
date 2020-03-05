variable "role_policies" {
    type = map(
        object({
        type = string
        identifiers = list(string)
        iam_policy_name = string
        iam_policy_description = string
    }))

    default = {
        full_access_role = {
            type = "AWS"
            identifiers = ["account 1", "account 2"]
            iam_policy_name = "full_access"
            iam_policy_description = "full access description"
        }
    }
}