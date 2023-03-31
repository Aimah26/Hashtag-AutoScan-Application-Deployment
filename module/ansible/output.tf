output "ansible_IP" {
  value       = aws_instance.ansible.public_ip
  description = "ansible private IP"
}
output "ansible_id" {
  value       = aws_instance.ansible.id
  description = "ansible Instance ID"
}