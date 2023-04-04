variable "aws_region" {
  default = "eu-west-1"
}

variable "vpc_name" {
  default = "VPC"
}

variable "name" {
  default = "Hash-App"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "az1" {
  default = "eu-west-1a"
}

variable "az2" {
  default = "eu-west-1b"
}

variable "prv-sn1" {
  default = "10.0.1.0/24"
}

variable "prv-sn2" {
  default = "10.0.2.0/24"
}

variable "pub-sn1" {
  default = "10.0.3.0/24"
}

variable "pub-sn2" {
  default = "10.0.4.0/24"
}
