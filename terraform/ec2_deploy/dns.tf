locals {
  domain = "example.com"
}

resource "aws_route53_zone" "zone" {
  name = local.domain
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.zone.zone_id
  name = local.domain
  type = "A"
  ttl = "300"
  records = ["${aws_lb.lb.dns_name}"]
}

module "acm" {
  source = "terraform-aws-modules/acm/aws"
  
  domain_name = local.domain
  zone_id = aws_route53_zone.zone.zone_id
  wait_for_validation = true
}
