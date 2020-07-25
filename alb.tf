resource "aws_lb" "prd" {
  name               = "${var.service_name}-alb-app"
  load_balancer_type = "application"
  internal           = false
  idle_timeout       = 300

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_c.id,
  ]

  security_groups = [
    aws_security_group.alb.id,
  ]
}

resource "aws_lb_listener" "http_to_https" {
  load_balancer_arn = aws_lb.prd.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.prd.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.default.arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.prd.arn}"
  }
}

resource "aws_lb_target_group" "prd" {
  name                 = "${var.service_name}-tg"
  vpc_id               = aws_vpc.default.id
  target_type          = "ip"
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
    port                = 8080
    protocol            = "HTTP"
  }

  depends_on = [aws_lb.prd]
}

resource "aws_lb_listener_rule" "prd" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prd.arn
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}
