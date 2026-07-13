output "vm_id" {
  value = azurerm_virtual_machine.main.id
}
output "ip_configuration" {
    value = azurerm_network_interface.main.ip_configuration
}
