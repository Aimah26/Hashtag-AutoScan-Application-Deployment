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

output "jenkins_elb_dns" {
  value = module.jenkins_elb.jenkins_elb_dns
}

output "prod_elb_dns" {
  value = module.Prod_elb.prod_elb_dns
}

output "Docker_IP" {
  value = module.docker.*.Docker_IP
}

output "ansible_IP" {
  value = module.ansible.ansible_IP
}

output "Continuous-ip" {
  value = module.Cont_Instance.Cont_Instance_IP
}

output "lb_DNS" {
  value = module.alb.lb_DNS
}

output "Stage_lb_dns" {
  value = module.stage_lb.stage_lb_DNS
}

output "name_servers" {
  value = module.route53.name_servers
}