provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags = {
    "ExemptFromCleanup" : "True"
  }
}

module "acas_servers" {
  source                  = "./modules/az-vms"
  for_each                = local.vm_specs
  vm_name                 = each.key
  resource_group_name     = azurerm_resource_group.main.name
  resource_group_location = azurerm_resource_group.main.location
  vm_size                 = each.value.size
  existing_subnet_name    = var.existing_subnet_name
  existing_vnet_name      = var.existing_vnet_name
  existing_vnet_rg        = var.existing_vnet_rg
  vm_admin_username       = var.vm_admin_username
  vm_image_offer_name     = var.vm_image_offer_name
  vm_image_pub_name       = var.vm_image_pub_name
  vm_image_sku            = var.vm_image_sku
  vm_image_version        = var.vm_image_version
}



#resource "local_file" "vm_ips" {
#  filename = "${module.acas_servers}/mydata.json"
#  content  = jsonencode(local.output_data.ip_addresses)
#}
