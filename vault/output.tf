#Vault IP address
output "Vault_ip" {
  value = aws_instance.vault.public_ip
}