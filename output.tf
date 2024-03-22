output "vm_private_ips" {
  value = [for ip in module.acas_servers : ip.vm_private_ip]
}