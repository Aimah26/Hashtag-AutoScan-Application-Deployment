variable "asg-group-name"{
    default = "stage_asg"
}
variable "vpc_subnet1" {
    default = "dummy"
}
variable "vpc_subnet2" {
    default = "dummy"
}
variable "lb_arn" {
    default = "dummy"
}
variable "asg-policy" {
    default = "stage_asg_policy"
}
variable "lc_name" {
    default = "stage_lc_name"
}
variable "lc_instance_type" {
    default = "t3.medium"
}
variable "asg_sg" {
    default = "dummy"
}
variable "key_pair" {
    default = "dummy"
}
variable "launch_ami_name" {
    default = "stage_lc_ami"
}

variable "amiLC" {
  default = "dummy"
}