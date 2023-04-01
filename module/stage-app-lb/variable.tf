variable "name_lb" {
    default = "stage-lb"
}

variable "lb_security" {
    default = "dummy"
}

variable "lb_subnet1" {
    default = "dummy"
}

variable "lb_subnet2" {
    default = "dummy"
}

variable "env" {
    default = "stage"
}

variable "lb_TG_name" {
    default = "stage-lb-TG"
}

variable "vpc_name" {
    default = "dummy"
}

variable "target_instance" {
    default = "dummy"
}                                       

variable "http_port" {
  default = 80
}

variable "proxy_port1" {
  default = 8080
}