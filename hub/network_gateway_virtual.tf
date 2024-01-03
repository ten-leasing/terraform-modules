locals {
  tenant_id                        = data.azurerm_client_config.current.tenant_id
  azure_public_audience            = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
  gateway_client_vpn_address_size  = 24
  gateway_client_vpn_address_space = "192.168.202.0/${local.gateway_client_vpn_address_size}"
  gateway_subnet_size              = 27
  gateway_subnet_newbits           = local.gateway_subnet_size - local.hub_vnet_reserved_subnet_size
}

data "azurerm_client_config" "current" {}

variable "virtual_network_gateway_sku" {
  type    = string
  default = "VpnGw2"
}

resource "azurerm_public_ip" "gateway" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${var.resource_name_prefix}-internal-vgw-pip"
  tags                = merge(var.tags, {})
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${var.resource_name_prefix}-gw"
}

output "gateway_public_ip_domain_name" {
  value = azurerm_public_ip.gateway.domain_name_label
}

output "gateway_public_ip_id" {
  value = azurerm_public_ip.gateway.id
}

output "gateway_public_ip" {
  value = azurerm_public_ip.gateway.ip_address
}

resource "azurerm_subnet" "gateway" {
  resource_group_name  = azurerm_virtual_network.hub.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name
  name                 = "GatewaySubnet"
  address_prefixes = [
    cidrsubnet(azurerm_virtual_network.hub.address_space.0, local.gateway_subnet_newbits, 1)
  ]
}

resource "azurerm_virtual_network_gateway" "internal" {
  resource_group_name = azurerm_public_ip.gateway.resource_group_name
  location            = azurerm_public_ip.gateway.location

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
