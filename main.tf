# VPC
module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  name                   = var.vpc_name
  cidr                   = var.vpc_cidr
  azs                    = [var.az1, var.az2]
  private_subnets        = [var.prv-sn1, var.prv-sn2]
  public_subnets         = [var.pub-sn1, var.pub-sn2]
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  tags = {
    Terraform = "true"
    Name      = "${var.name}-vpc"
  }
}

# security Group
module "sg" {
  source  = "./module/sg"
  Hash-vpc = module.vpc.vpc_id
}

module "key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  key_name   = var.keyname
  public_key = file("~/keypairs/Hashkey.pub")
}

module "Sonarqube" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.sonar-name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.sonarqube-sg-id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data              = file("module/User_Data/sonar.sh")
  tags = {
    Terraform = "true"
    Name      = "${var.name}-sonar-server"
  }
}

module "Bastion" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = var.ec2_name
  ami                    = var.ec2_ami
  instance_type          = var.instancetype
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.bastion-sg-id]
  subnet_id              = module.vpc.public_subnets[0]
  user_data = templatefile("module/User_Data/bastion-userdata.sh",
    {
      keypair = "~/keypairs/Hashkey"
    }
  )
  tags = {
    Terraform = "true"
    Name      = "${var.name}-Bastion"
  }
}

module "jenkins" {
  source = "./module/jenkins"
  instance_type = var.instancetype
  ami = var.ec2_ami
  azs = var.az1
  subnet_id = module.vpc.private_subnets[0]
  key_name = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.jenkins-sg-id]
}

module "jenkins_lb" {
  source = "./module/jenkins-lb"
  lb_security = module.sg.alb-sg-id
  lb_subnet1 = module.vpc.public_subnets[0]
  lb_subnet2 = module.vpc.public_subnets[1]
  target_instance = module.jenkins.jenkins_ID
}

module "docker" {
  source = "./module/docker"
  instance_type = var.instancetype
  ami = var.ec2_ami
  azs = var.az2
  subnet_id = module.vpc.private_subnets[1]
  key_name = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.sg.docker-sg-id]
}

module "docker_lb" {
  source = "./module/docker-lb"
  lb_security = module.sg.alb-sg-id
  lb_subnet1 = module.vpc.public_subnets[0]
  lb_subnet2 = module.vpc.public_subnets[1]
  target_instance = module.docker.docker_id
}

module "nexus" {
  source = "./module/nexus"
  instance_type = var.instancetype
  ami = var.ec2_ami
  key_name = module.key_pair.key_pair_name
  subnet_id = module.vpc.public_subnets[0]
  nexus_SG = [module.sg.nexus-sg-id]
}

module "ansible" {
  source = "./module/ansible"
  instance_type = var.instancetype
  ami = var.ec2_ami
  azs = var.az1
  key_name = module.key_pair.key_pair_name
  subnet_id = module.vpc.public_subnets[1]
  vpc_security_group_ids = [module.sg.ansible-sg-id]
}