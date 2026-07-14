# COMMON VARIABLES
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "mate-azure-task-12"
}
variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
  default     = "uksouth"
}
#______________________________________________________________________________|