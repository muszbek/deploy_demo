locals {
  domain = "tamasweb.com"
}

resource "aws_route53_zone" "zone" {
  name = local.domain
}

module "acm" {
  source = "terraform-aws-modules/acm/aws"
  
  domain_name = local.domain
  zone_id = aws_route53_zone.zone.zone_id
  wait_for_validation = true
}
