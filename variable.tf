variable "vpc_name" {
  default = "Hash-VPC"
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

variable "http_port" {
  default = 80
}

variable "keyname" {
  default = "Hashkey"
}

variable "ssh_port" {
  default = 22
}

variable "proxy_port1" {
  default = 8080
}

variable "proxy_port2" {
  default = 9000
}

variable "MySQL_port" {
  default = 3306
}

variable "des_http" {
  default = "This port allows http access"
}

variable "des_ssh" {
  default = "This port allows ssh access"
}


variable "proxy" {
  default = "This port allows proxy access"
}

variable "prot" {
  default = "tcp"
}

variable "all_access" {
  default = "0.0.0.0/0"
}

variable "ec2_name" {
  default = "Hash-ec2"
}

variable "sonar-name" {
  default = "sonar-sever"
}

variable "ec2_ami" {
  default = "ami-0b04ce5d876a9ba29"
}

variable "instancetype" {
  default = "t3.medium"
}

variable "docker_name" {
  default = "docker"
}

#ASG Variables
variable "ami-name" {
  default = "host_ami"
}
variable "target-instance" {
  default = "docker_server"
}
variable "launch-configname" {
  default = ""
}

variable "sg_name3" {
  default = ""
}

variable "asg-group-name" {
  default = "asg"
}
variable "vpc-zone-identifier" {
  default = ""
}
variable "target-group-arn" {
  default = ""
}
variable "asg-policy" {
  default = ""
}
variable "domain_name" {
  default = "adfimah.com"
}

variable "new_relic_key" {
  default = "eu01xxbca018499adedd74cacda9d3d13e7dNRAL"
}

# variable "nexus-ip" {}

variable "doc_pass" {
  default = "Ibrahim24."
}

variable "doc_user" {
  default = "daicon001"
}