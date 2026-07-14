resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ip_config"
    subnet_id                     =  var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id
  }
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = var.NSG_id
}

resource "azurerm_ssh_public_key" "example" {
  name                = var.SSH_key
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  public_key          = file("~/.ssh/id_rsa.pub")
}

resource "azurerm_virtual_machine" "main" {
  name                  = var.vm_name
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.vm_size
  
  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false

    ssh_keys {
      path = "/home/testadmin/.ssh/authorized_keys"
      key_data = azurerm_ssh_public_key.example.public_key
    }
  }
}

resource "azurerm_virtual_machine_extension" "example" {
  name                 = var.extension_name
  virtual_machine_id   = azurerm_virtual_machine.main.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  protected_settings = jsonencode({
    script = base64encode(file("${path.module}/../../${var.path_to_script}"))
  })

}