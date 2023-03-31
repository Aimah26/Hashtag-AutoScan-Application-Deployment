output "vpc_id" {
  value = module.vpc.vpc_id
}

output "Sonar-pub_ip" {
  value = module.Sonarqube.public_ip
}

output "Bastion_ip" {
  value = module.Bastion.public_ip
}
output "jenkins_IP" {
  value = module.jenkins.jenkins_IP
}

output "jenkins_lb" {
  value = module.jenkins_lb.lb_DNS
}

output "Docker_IP" {
  value = module.docker.Docker_IP
}

output "docker_lb" {
  value = module.docker_lb.lb_DNS
}

output "nexus-ip" {
  value = module.nexus.nexus-ip
}

output "ansible_IP" {
  value = module.ansible.ansible_id
}