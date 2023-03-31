output "jenkins_IP" {
  value       = aws_instance.jenkins.private_ip 
  description = "jenkins private IP"
}
output "jenkins_ID" {
  value       = aws_instance.jenkins.id
  description = "jenkins id "
}