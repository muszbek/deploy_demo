resource "aws_iam_policy" "ebs_csi" {
  name = "iam_ebs_csi_policy"
  path = "/"
  description = "Allows instances to provision volumes"

  policy = "${file("./policies/ebs_csi_driver.json")}"
}

resource "aws_iam_role" "ebs_csi" {
  name = "iam_ebs_csi_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
	Effect = "Allow"
	Principal = {
	  Federated = "arn:aws:iam::${local.account_id}:${local.oidc_provider_id}"
	}
	Action = "sts:AssumeRoleWithWebIdentity"
	Condition = {
	  StringEquals = {
	    "${local.oidc_provider_id}:aud" = "sts.amazonaws.com"
	    "${local.oidc_provider_id}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
	  }
	}
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ebs_csi" {
  role = aws_iam_role.ebs_csi.name
  policy_arn = aws_iam_policy.ebs_csi.arn
}
