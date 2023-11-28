data "aws_route53_zone" "route53" {
  name = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "www" {
    zone_id = data.aws_route53_zone.route53.zone_id
    name = "${var.sub_domain}.${var.domain_name}"
    type = "A"
    alias {
        name = var.this_lb.dns_name
        zone_id = var.this_lb.zone_id
        evaluate_target_health = true
    }
}