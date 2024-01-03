locals {
  global_vnet_address_prefix = "10.10"
  global_vnet_address_size   = 16
  global_vnet_address_space  = "${local.global_vnet_address_prefix}.0.0/${local.global_vnet_address_size}"
}

output "vnet_global_address_size" {
  value = local.global_vnet_address_size
}

output "vnet_global_address_space" {
  value = local.global_vnet_address_space
}
