resource "aws_instance" "ansible" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  availability_zone           = var.azs
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_instance_profile
  associate_public_ip_address = true
  user_data = var.user_data
  
  # user_data = file("module/User_Data/ansible.sh")


  tags = {
    Name = "ansible"
  }
}