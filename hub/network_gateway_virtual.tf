locals {
  tenant_id                        = data.azurerm_client_config.current.tenant_id
  azure_public_audience            = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
  gateway_client_vpn_address_size  = 24
  gateway_client_vpn_address_space = "192.168.202.0/${local.gateway_client_vpn_address_size}"
  gateway_subnet_address_prefixes  = cidrsubnet(one(azurerm_virtual_network.main.address_space), 0, 0)
}

data "azurerm_client_config" "current" {}

variable "virtual_network_gateway_sku" {
  type    = string
  default = "VpnGw2"
}

resource "azurerm_subnet" "gateway" {
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  name                 = "GatewaySubnet"
  address_prefixes     = [local.gateway_subnet_address_prefixes]
}

output "gateway_subnet_address_prefixes" {
  value = azurerm_subnet.gateway.address_prefixes
}

resource "azurerm_virtual_network_gateway" "internal" {
  resource_group_name = var.resource_group_name
  location            = var.location

  name          = "${var.resource_name_prefix}-internal-vgw"
  sku           = var.virtual_network_gateway_sku
  type          = "Vpn"
  generation    = "Generation2"
  active_active = false
  enable_bgp    = false
  vpn_type      = "RouteBased"

  tags = merge(var.tags, {})

  ip_configuration {
    name                          = "internal-vgw-ip_config"
    subnet_id                     = azurerm_subnet.gateway.id
    public_ip_address_id          = azurerm_public_ip.gateway.id
    private_ip_address_allocation = "Dynamic"
  }

  vpn_client_configuration {
    address_space        = [local.gateway_client_vpn_address_space]
    vpn_auth_types       = ["AAD"]
    vpn_client_protocols = ["OpenVPN"]
    aad_tenant           = "https://login.microsoftonline.com/${local.tenant_id}"
    aad_audience         = local.azure_public_audience
    aad_issuer           = "https://sts.windows.net/${local.tenant_id}/"
  }
}
