output "name_servers" {
  value = data.aws_route53_zone.Hash-domain.name_servers
}

output "zone_id" {
  value = data.aws_route53_zone.Hash-domain.zone_id
}