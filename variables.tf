resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}

variable "prefix" {
  description = "naming prefix (beginning)"
  default     = "dilz"
}

variable "infix" {
  description = "naming infix (middle)"
  default     = "acas"
}

variable "postfix" {
  description = "naming postfix (end)"
  default     = "ugv"
}

variable "resource_group_name" {
  description = "azure resource group name"
  type        = string
}

variable "resource_group_location" {
  description = "azure resource group location"
  type        = string
}

variable "existing_vnet_rg" {
  description = "name of existing resource group name for vnet"
  type        = string
}

variable "existing_vnet_name" {
  description = "name of existing vnet to attach vm to"
  type        = string
}

variable "existing_subnet_name" {
  description = "name of existing subnet name"
  type        = string
}

#variable "vm_nic_name" {
#  description = "name of NIC card to create for vm"
#  type = string
#}

variable "vm_nic_ip_conf_settings" {
  description = "ip configuration for vm nic"
  default     = "Dynamic"
}

variable "vm_admin_username" {
  description = "username for admin user for vm"
  type        = string
  sensitive   = true
  default     = "acas"
}

variable "vm_admin_ssh_key_path" {
  description = "path the the ssh key (pub) for the admin to use"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "vm_size" {
  description = "size information for vm"
  type        = string
  default     = "Standard_F2"
}

variable "vm_disk_type" {
  description = "disk type for os disk"
  default     = "Standard_LRS"
}

variable "vm_image_offer_name" {
  description = "name of image eg: RHEL"
  type        = string
  default     = "RHEL"
}

variable "vm_image_pub_name" {
  description = "name of image publisher eg: RedHat"
  type        = string
  default     = "RedHat"
}

variable "vm_image_sku" {
  description = "name of image sku eg: 8-LVM"
  type        = string
  default     = "8-LVM"
}

variable "vm_image_version" {
  description = "image version eg: latest"
  type        = string
  default     = "latest"
}


