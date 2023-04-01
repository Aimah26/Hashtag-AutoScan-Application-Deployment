output "zone_id" {
    value = data.aws_route53_zone.main-domain.zone_id 
  
}

output "zone_name" {
    value = data.aws_route53_zone.main-domain.name
}