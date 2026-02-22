remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "gmmcal-production-tfstate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "eu-west-1"
  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["145930272434"]
  default_tags {
    tags = {
      "managed-by" = "terraform"
    }
  }
}
provider "aws" {
  alias  = "eu-west-1"
  region = "eu-west-1"
  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["145930272434"]
  default_tags {
    tags = {
      "managed-by" = "terraform"
    }
  }
}
EOF
}
