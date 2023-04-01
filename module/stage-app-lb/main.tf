#creating Load Balancer
resource "aws_lb" "stage_lb" {
  name               = var.name_lb
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_security]
  subnets            = [var.lb_subnet1, var.lb_subnet2]
  enable_deletion_protection = false 
  tags = {
    Environment = var.env
  }
}
#creating Load balancer Target Group                                    
resource "aws_lb_target_group" "stage_lb_TG" {
  name     = var.lb_TG_name
  target_type = "instance"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_name
  health_check {
    healthy_threshold = 3
    unhealthy_threshold = 3
    timeout = 4
    interval = 45
  }
}
# creating Load balancer Listener
resource "aws_lb_listener" "stage_lb_listener" {
  load_balancer_arn = aws_lb.stage_lb.arn
  port              = var.http_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.stage_lb_TG.arn
  }
}

#creating Load balancer Target Group Attachment
resource "aws_lb_target_group_attachment" "pacaad_lb_tg_att_QA" {
  target_group_arn = aws_lb_target_group.stage_lb_TG.arn
  target_id        = var.target_instance
  port             = var.proxy_port1
}