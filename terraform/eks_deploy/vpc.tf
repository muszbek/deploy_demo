locals {
  cluster_name = "demo-cluster"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = "vpc"

  azs = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
  cidr = "10.0.0.0/16"

  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

  enable_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}
