output "lb_tg" {
    value = aws_lb_target_group.docker_lb_TG.arn
}

output "lb_DNS" {
    value = aws_lb.docker_lb.dns_name
}

output "lb_zone_id" {
    value = aws_lb.docker_lb.zone_id
}

output "lb_arn" {
    value = aws_lb.docker_lb.arn
}