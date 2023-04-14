data "aws_route53_zone" "Hash-domain" {
  name         = var.domain_name
  private_zone = false
}

# Route53 Record
resource "aws_route53_record" "Hash_record" {
  zone_id = data.aws_route53_zone.Hash-domain.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.lb_dns
    zone_id                = var.lb-zone-id
    evaluate_target_health = true
  }
}