output "public_ip_address" {
  value = azurerm_public_ip.tp4.ip_address
}

output "tls_private_key" {
  value     = tls_private_key.ssh.private_key_pem
  sensitive = true
}