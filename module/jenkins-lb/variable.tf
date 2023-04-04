variable "name_lb" {
    default = "jenkins-lb"
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
    default = "development"
}

variable "lb_TG_name" {
    default = "jenkins-lb-TG"
}

variable "vpc_name" {}

variable "target_instance" {
    default = "dummy"
}                                       

variable "http_port" {
  default = 80
}

variable "proxy_port1" {
  default = 8080
}