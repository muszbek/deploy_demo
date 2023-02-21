resource "aws_lb" "lb" {
  load_balancer_type = "application"
  internal = false
  subnets = module.vpc.private_subnets
  security_groups = [aws_security_group.http_sg.id]
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.lb.arn
  port = 443
  protocol = "HTTPS"
  certificate_arn = "${module.acm.acm_certificate_arn}"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  port = 80
  protocol = "HTTP"
  vpc_id = module.vpc.vpc_id
}

resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id = module.ec2.id
}
