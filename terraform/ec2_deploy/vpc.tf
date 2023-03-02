module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "vpc"

  azs = ["eu-west-3a", "eu-west-3b"]
  cidr = "10.0.0.0/16"

  public_subnets = ["10.0.11.0/24", "10.0.12.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_dns_hostnames = true
  enable_dns_support = true
}
