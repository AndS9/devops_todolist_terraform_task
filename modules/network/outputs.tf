output "Virtal_network_id" {
    value = azurerm_virtual_network.main.id
}
output "Public_IP" {
    value = azurerm_public_ip.mainIP.ip_address
}
output "Public_domain" {
    value = azurerm_public_ip.mainIP.domain_name_label
}