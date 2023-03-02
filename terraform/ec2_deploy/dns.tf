locals {
  domain = "tamasweb.com"
}

resource "aws_route53_zone" "zone" {
  name = local.domain
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.zone.zone_id
  name = local.domain
  type = "A"

  alias {
    name = aws_lb.lb.dns_name
    zone_id = aws_lb.lb.zone_id
    evaluate_target_health = true
  }
}

module "acm" {
  source = "terraform-aws-modules/acm/aws"
  
  domain_name = local.domain
  zone_id = aws_route53_zone.zone.zone_id
  wait_for_validation = true
}
