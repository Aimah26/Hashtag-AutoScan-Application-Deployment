#Creating EC2 for Nexus Server
resource "aws_instance" "nexus-Server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = var.nexus_SG
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  user_data = file("module/User_Data/nexus.sh")

tags = {
  Name = "nexus-Server"
 }
}


