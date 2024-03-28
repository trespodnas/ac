output "vm_private_ips" {
  value = [for ip in module.acas_servers : ip.vm_private_ip]
}
output "vm_name" {
  value = [for name in module.acas_servers : name.vm_name]
}