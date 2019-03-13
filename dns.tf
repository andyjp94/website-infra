resource "aws_route53_record" "self" {
  zone_id = "${var.hosted_zone_id}"
  name    = "${var.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.self.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.self.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  # count = "${var.www == true ? 1 : 0}"
  count = "${var.www == "true" ? 1 : 0}"

  # count = 1
  zone_id = "${var.hosted_zone_id}"
  name    = "www.${var.domain_name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${var.domain_name}"]
}
