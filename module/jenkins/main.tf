# Create Jenkins  (using Red Hat for ami and t2.medium for instance type)
resource "aws_instance" "jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id
  availability_zone      = var.azs
  key_name               = var.key_name
  user_data = file("module/User_Data/jenkins.sh")

tags = {
    Name = "jenkins"
  }
}