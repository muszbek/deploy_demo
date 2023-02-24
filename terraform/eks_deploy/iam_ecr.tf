resource "aws_iam_role_policy_attachment" "ecr_access" {
  role = module.eks.cluster_iam_role_arn
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
