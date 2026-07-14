output "resource_group" {
  value = data.azurerm_resource_group.main.name
}
output "location" {
  value = data.azurerm_resource_group.main.location
}

output "vm_id" {
  value = module.compute.vm_id
}
output "public_ip" {
  value = module.network.public_ip
}
output "public_domain" {
  value = module.network.public_domain
}
output "vm_ip_config" {
  value = module.compute.ip_configuration
}

output "container_taskartifacts_id" {
  value = module.storage.container_id
}

