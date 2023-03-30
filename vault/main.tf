provider "aws" {
  profile = "default"
  region = "eu-west-1"
}

#Creating EC2 Keypair
resource "aws_key_pair" "vault-keypair" {
  key_name   = "vault-keypair"
  public_key = file("~/keypairs/ssh_keypair.pub")
}

# Security group for vault
resource "aws_security_group" "vault-SG" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "https port"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "vault port"
    from_port        = 8200
    to_port          = 8200
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "ssh access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "vault-SG"
  }
}

# Creating EC2 for Terraform Vault
resource "aws_instance" "vault" {
    ami = "ami-05b457b541faec0ca"
    instance_type = "t2.medium"
    vpc_security_group_ids = [aws_security_group.vault-SG.id]
    iam_instance_profile = aws_iam_instance_profile.vault-kms-unseal.id
    key_name = aws_key_pair.vault-keypair.key_name
    associate_public_ip_address = true
    user_data = local.vault_user_data
    tags = {
        Name = "vault-server"
    }
}

resource "aws_kms_key" "vault" {
  description             = "vault unseal key"
  deletion_window_in_days = 10

  tags = {
    "Name" = "vault-kms-unseal"
  }
}

data "aws_route53_zone" "route53_zone" {
  name = "adfimah.com"
  private_zone = false
}

resource "aws_route53_record" "vault_record" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name = "adfimah.com"
  type = "A"
  records = [aws_instance.vault.public_ip]
  ttl = 300
}