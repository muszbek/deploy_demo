resource "aws_iam_policy" "external_dns" {
  name = "iam_external_dns_policy"
  path = "/"
  description = "Allows Kubernetes to create Route53 records based on ingress hostnames"

  policy = "${file("./policies/external_dns.json")}"
}

resource "aws_iam_role" "external_dns" {
  name = "iam_external_dns_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
	Effect = "Allow"
	Principal = {
	  Federated = "arn:aws:iam::${local.account_id}:oidc-provider/${local.oidc_provider_id}"
	}
	Action = "sts:AssumeRoleWithWebIdentity"
	Condition = {
	  StringEquals = {
	    "${local.oidc_provider_id}:aud" = "sts.amazonaws.com"
	    "${local.oidc_provider_id}:sub" = "system:serviceaccount:kube-system:external-dns"
	  }
	}
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  role = aws_iam_role.external_dns.name
  policy_arn = aws_iam_policy.external_dns.arn
}
