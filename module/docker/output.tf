output "Docker_IP" {
  value       = aws_instance.docker.private_ip
  description = "Docker private IP"
}
output "docker_id" {
  value       = aws_instance.docker.id
  description = "Docker Instance ID"
}