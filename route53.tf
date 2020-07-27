data "aws_route53_zone" "default" {
  name = var.domain_name
  private_zone = false
}

## ACM
resource "aws_route53_record" "cert_default" {
  name    = "${aws_acm_certificate.default.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.default.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.default.id}"
  records = ["${aws_acm_certificate.default.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_route53_record" "prd" {
  zone_id = data.aws_route53_zone.default.id
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    evaluate_target_health = false
    name                   = "${aws_lb.prd.dns_name}"
    zone_id                = "${aws_lb.prd.zone_id}"
  }
}
