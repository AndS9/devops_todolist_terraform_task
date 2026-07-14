variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
}

variable "pip_name" {
  description = "Name of public IP resource"
  type        = string
  default     = "linuxboxpip"
}

variable "vm_name" {
  description = "Virtual Machine Name"
  type        = string
  default     = "matebox"
}
variable "vm_size" {
  description = "Size of VM"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "subnet_id" {
  type = string
}

variable "public_ip_id" {
  type = string
}

variable "NSG_id" {
  type = string
}

variable "extension_name" {
  type    = string
  default = "CustomScript"
}
variable "path_to_script" {
  type = string
}

variable "SSH_key" {
  type    = string
  default = "linuxboxsshkey"
}