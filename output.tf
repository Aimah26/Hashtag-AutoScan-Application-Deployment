output "vpc_id" {
  value = module.vpc.vpc_id
}

output "Sonar-pub_ip" {
  value = module.Sonarqube.public_ip
}

output "Bastion_ip" {
  value = module.Bastion.public_ip
}