locals {
  region = "eu-west-3"
}

provider "aws" {
  region = local.region
  access_key = "test"
  secret_key = "test"
}
