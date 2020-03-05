provider "aws" {
    region = "us-east-2" 
}


data "aws_iam_policy_document" "instance_assume_role_policy" {
    for_each = var.role_policies

    statement {
        sid = "AssumeRole"
        actions = ["sts:AssumeRole"]
    
    principals {
        type = each.value.type
        identifiers = each.value.identifiers
    }
  }
}

data "aws_iam_policy_document" "iam_policy_for_role" {
    statement {
        sid = "IAMPolicy"
        actions = ["iam:ListUsers"]
  }
}

resource "aws_iam_role" "role_instance" {
    for_each = var.role_policies
    name               = each.key
    assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy[each.key].json
}

locals {
    iam_policies_map = {
        full_access = data.aws_iam_policy_document.iam_policy_for_role.json
    }
}

resource "aws_iam_policy" "iam_policy" {
    for_each = var.role_policies
    
    name        = each.value.iam_policy_name
    description = each.value.iam_policy_description
    
    policy = local.iam_policies_map[each.value.iam_policy_name]
}

resource "aws_iam_role_policy_attachment" "policy_attach_to_role" {
    for_each = var.role_policies
    role       = aws_iam_role.role_instance[each.key].name
    policy_arn = aws_iam_policy.iam_policy[each.key].arn
}