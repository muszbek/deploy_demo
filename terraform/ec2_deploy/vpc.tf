module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "vpc"

  azs = ["eu-west-3a"]
  cidr = "10.0.0.0/16"

  public_subnets = ["10.0.1.0/24"]
  private_subnets = ["10.0.2.0/24"]

  enable_dns_hostnames = true
  enable_dns_support = true
}
