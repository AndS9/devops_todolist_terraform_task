# COMMON VARIABLES
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resource group"
  type        = string
}
#______________________________________________________________________________|

# NETWORK's VARIABLES
variable "prefix" {
  type    = string
  default = "myapp"
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet"
}
variable "vnet_address_prefix" {
  description = "Virtual network address prefix"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "default"
}

variable "subnet_address_prefix" {
  description = "Subnet address prefix"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}
variable "public_ip_address_name" {
  description = "Name of the puplic ip resource"
  type        = string
  default     = "linuxboxpip"
}
variable "dns_label" {
  description = "DNS for service"
  type        = string
  default     = "matetask"
}
variable "network_security_group_name" {
  description = "Name of Network Security Group"
  type        = string
  default     = "defaultnsg"
}

variable "security_rules" {
  description = "List of security rules for the network security group"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "SSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "HTTP"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}
#______________________________________________________________________________|


