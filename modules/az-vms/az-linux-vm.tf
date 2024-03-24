#provider "azurerm" {
#  features {}
#}



#data "azurerm_resource_group" "existing_vnet_rg" {
#  name = var.existing_vnet_rg
#}

data "azurerm_subnet" "existing_subnet_name" {
  name                 = var.existing_subnet_name
  resource_group_name  = var.existing_vnet_rg
  virtual_network_name = var.existing_vnet_name
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-${var.infix}-nic-${random_string.random.result}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  ip_configuration {
    name                          = "${var.prefix}-${var.infix}-${random_string.random.result}"
    private_ip_address_allocation = var.vm_nic_ip_conf_settings
    subnet_id                     = data.azurerm_subnet.existing_subnet_name.id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  admin_username      = var.vm_admin_username
  location            = var.resource_group_location
  size                = var.vm_size
  secure_boot_enabled = true
  network_interface_ids = [
    azurerm_network_interface.main.id
  ]
  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = file(var.vm_admin_ssh_key_path)
  }
  source_image_reference {
    offer     = var.vm_image_offer_name
    publisher = var.vm_image_pub_name
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vm_disk_type
  }
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.vm_admin_username} -i ${azurerm_linux_virtual_machine.main.private_ip_address}, config-mgmt/basic_config.yml"
  }
}










