# Create EC2 Instance for Docker host using a t2.micro RedHat ami
  resource "aws_instance" "docker" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  availability_zone           = var.azs
  key_name                    = var.key_name
  count                       = 3
  user_data = file("module/User_Data/docker.sh")

  tags = {
    Terraform = "true"
    Name      = "${ var.docker_name}${count.index}"
  }
  }