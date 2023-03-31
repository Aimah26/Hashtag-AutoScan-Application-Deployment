# Create EC2 Instance for Docker host using a t2.micro RedHat ami
  resource "aws_instance" "docker" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  availability_zone           = var.azs
  key_name                    = var.key_name
  user_data = file("module/User_Data/jenkins.sh")

  tags = {
    Name = "docker"
  }
  }