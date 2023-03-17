module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name = local.cluster_name

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    group1 = {
      name = "node-group-1"

      instance_types = ["t2.medium"]

      min_size = 1
      max_size = 3
      desired_size = 2
    }
  }
}

locals {
  oidc_provider_id = regex("(https:\\/\\/)(.*$)", module.eks.cluster_oidc_issuer_url)[1]
}

resource "null_resource" "eks_kubeconfig" {
  provisioner "local-exec" {
    command = "rm -f ~/.kube/config && aws eks update-kubeconfig --name ${local.cluster_name} --region ${local.region}"
  }

  depends_on = [module.eks]
}
