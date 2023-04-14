# Create EC2 Instance for continuous testing using a t2.micro RedHat ami
  resource "aws_instance" "Cont_Instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  availability_zone           = var.azs
  key_name                    = var.key_name
  user_data = file("module/User_Data/Cont_instance.sh")

  tags = {
    Name = "Cont_Instance"
  }
  }