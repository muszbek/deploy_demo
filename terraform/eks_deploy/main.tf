locals {
  region = "eu-west-3"
}

provider "aws" {
  region = local.region
  access_key = "test"
  secret_key = "test"
}


data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
}
