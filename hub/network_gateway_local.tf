locals {
  on_prem_address_space = ["10.135.159.0/24", "192.168.10.0/24"]
}

variable "vpn_appliance_pre_shared_key" {
  type      = string
  sensitive = true
}

variable "vpn_appliance_address" {
  type      = string
  sensitive = true
}

resource "azurerm_local_network_gateway" "internal" {
  resource_group_name = azurerm_virtual_network.main.resource_group_name
  location            = azurerm_virtual_network.main.location
  tags                = merge(var.tags, {})

  name            = "${var.resource_name_prefix}-internal-lgw"
  gateway_address = var.vpn_appliance_address
  address_space   = local.on_prem_address_space
}

resource "azurerm_virtual_network_gateway_connection" "internal" {
  resource_group_name        = azurerm_local_network_gateway.internal.resource_group_name
  location                   = azurerm_local_network_gateway.internal.location
  virtual_network_gateway_id = azurerm_virtual_network_gateway.internal.id
  local_network_gateway_id   = azurerm_local_network_gateway.internal.id

  name                = "internal-connection"
  tags                = merge(var.tags, {})
  type                = "IPsec"
  shared_key          = var.vpn_appliance_pre_shared_key
  dpd_timeout_seconds = 45
  routing_weight      = 10

  ipsec_policy {
    ike_encryption   = "AES256"
    ipsec_encryption = "AES256"
    ike_integrity    = "SHA256"
    ipsec_integrity  = "SHA256"
    pfs_group        = "None"
    dh_group         = "DHGroup14"
    sa_datasize      = 102400000
    sa_lifetime      = 27000
  }
}

output "reporting_connection_key" {
  sensitive = true
  value     = var.vpn_appliance_pre_shared_key
}
