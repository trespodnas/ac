locals {
  vm_specs = {
    "dilz-acas-prod-securitycenter-ugv-1" = {
      location = "eastus"
      size     = "Standard_D16ls_v5"
    }
    "dilz-acas-prod-scan-ugv-1" = {
      location = "eastus"
      size     = "Standard_D8s_v3"
    }
    "dilz-acas-prod-scan-ugv-2" = {
      location = "eastus"
      size     = "Standard_D8s_v3"
    }
  }
}
