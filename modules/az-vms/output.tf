output "vm_private_ip" {
  value = azurerm_linux_virtual_machine.main.private_ip_address
}
output "vm_name" {
  value = azurerm_linux_virtual_machine.main.name
}