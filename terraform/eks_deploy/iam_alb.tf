resource "aws_iam_policy" "alb_controller" {
  name = "iam_alb_controller_policy"
  path = "/"
  description = "Allows Kubernetes ingress to root traffic via ALB"

  policy = "${file("./policies/alb_controller.json")}"
}

resource "aws_iam_role" "alb_controller" {
  name = "iam_alb_controller_role"

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
	    "${local.oidc_provider_id}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
	  }
	}
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "alb_controller" {
  role = aws_iam_role.alb_controller.name
  policy_arn = aws_iam_policy.alb_controller.arn
}
