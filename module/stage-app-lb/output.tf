
output "stage_lb_tg" {
    value = aws_lb_target_group.stage_lb_TG.arn
}

output "stage_lb_DNS" {
    value = aws_lb.stage_lb.dns_name
}

output "stage_lb_zone_id" {
    value = aws_lb.stage_lb.zone_id
}

output "stage_lb_arn" {
    value = aws_lb.stage_lb.arn
}