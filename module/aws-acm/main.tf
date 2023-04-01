# resource "aws_route53_zone" "primary" {
#   name = var.domain_name
#   false_destroy =  true
# } 
# first create hosted zone manually and register the name server on your domain provider

resource "aws_acm_certificate" "Hash_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"
}
data "aws_route53_zone" "main-domain" {
  name         = var.domain_name
  private_zone = false
}
resource "aws_route53_record" "Hash_routerecord" {
  for_each = {
    for dvo in aws_acm_certificate.Hash_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.main-domain.zone_id
}
resource "aws_acm_certificate_validation" "Hash_certvalid" {
  certificate_arn         = aws_acm_certificate.Hash_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.Hash_routerecord : record.fqdn]
}
# creating Load balancer Listener
resource "aws_lb_listener" "Hash_lb_listener" {
  load_balancer_arn = var.lb_arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate_validation.Hash_certvalid.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = var.lb_target_arn
  }
}

resource "aws_lb_listener" "Hash_lb_listener2" {
  load_balancer_arn = var.lb_arn2
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate_validation.Hash_certvalid.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = var.lb_target_arn2
  }
}

resource "aws_route53_record" "name" {
  name = var.domain_name1
  type = "A"
  zone_id = data.aws_route53_zone.main-domain.id
    alias  {
      name                   = var.lb_arn
      zone_id                = var.lb-zone-id
      evaluate_target_health = false
    }
}

resource "aws_route53_record" "name2" {
  name = var.domain_name2
  type = "A"
  zone_id = data.aws_route53_zone.main-domain.id
    alias  {
      name                   = var.stage-lb-dns
      zone_id                = var.stage-lb-zone-id
      evaluate_target_health = false
    }
}