include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::https://www.github.com/gmmcal/gmmcal-iac-modules.git//modules/iam/deploy-role?ref=v0.3.0"
}

inputs = {
  role_name      = "github.gmmcal.iac"
  aws_account_id = "145930272434"
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
  ]
  conditions = [
    {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    },
    {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:gmmcal@1676127/gmmcal-iac@878294751:*"
      ]
    },
  ]
}
