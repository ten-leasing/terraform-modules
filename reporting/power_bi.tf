locals {
  power_bi_overall_address_range = [cidrsubnet(data.terraform_remote_state.global.outputs.vnet_global_address_space, 8, 5)]
  logins                         = { "powerbi.reporting@starleasing.com" : "public" }
}

data "azurerm_mssql_managed_instance" "main" {
  resource_group_name = "${var.resource_name_prefix}-data"
  name                = "${var.resource_name_prefix}-mi"
}

resource "azurerm_virtual_network" "power_bi" {
  resource_group_name = azurerm_resource_group.reporting.name
  location            = azurerm_resource_group.reporting.location
  tags                = merge(var.tags, {})

  name = "${var.resource_name_prefix}-power_bi-vnet"

  address_space = local.power_bi_overall_address_range
}

resource "azurerm_subnet" "power_bi" {
  resource_group_name  = azurerm_virtual_network.power_bi.resource_group_name
  virtual_network_name = azurerm_virtual_network.power_bi.name

  name = "PowerBIDataGateway"

  delegation {
    name = "power_bi_data_gateway"
    service_delegation {
      name    = "Microsoft.PowerPlatform/vnetaccesslinks"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

  address_prefixes = [cidrsubnet(azurerm_virtual_network.power_bi.address_space[0], 4, 0)]
}

module "power_bi_and_reporting_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name           = azurerm_virtual_network.power_bi.resource_group_name
  vnet1_name                          = azurerm_virtual_network.power_bi.name
  vnet1_id                            = azurerm_virtual_network.power_bi.id
  vnet1_address_space                 = azurerm_virtual_network.power_bi.address_space
  vnet1_allow_vnet2_forwarded_traffic = false
  vnet1_allow_vnet2_gateway_transit   = false

  vnet2_resource_group_name           = data.azurerm_virtual_network.reporting.resource_group_name
  vnet2_name                          = data.azurerm_virtual_network.reporting.name
  vnet2_id                            = data.azurerm_virtual_network.reporting.id
  vnet2_address_space                 = data.azurerm_virtual_network.reporting.address_space
  vnet2_allow_vnet1_forwarded_traffic = false
  vnet2_use_vnet1_remote_gateway      = false
}

module "power_bi_and_data_peering" {
  source = "git::https://star-leasing@dev.azure.com/star-leasing/Architecture/_git/terraform-library//azure-vnet-peerings?ref=default"

  vnet1_resource_group_name           = azurerm_virtual_network.power_bi.resource_group_name
  vnet1_name                          = azurerm_virtual_network.power_bi.name
  vnet1_id                            = azurerm_virtual_network.power_bi.id
  vnet1_address_space                 = azurerm_virtual_network.power_bi.address_space
  vnet1_allow_vnet2_forwarded_traffic = false
  vnet1_allow_vnet2_gateway_transit   = false

  vnet2_resource_group_name           = data.azurerm_virtual_network.managed_instance.resource_group_name
  vnet2_name                          = data.azurerm_virtual_network.managed_instance.name
  vnet2_id                            = data.azurerm_virtual_network.managed_instance.id
  vnet2_address_space                 = data.azurerm_virtual_network.managed_instance.address_space
  vnet2_allow_vnet1_forwarded_traffic = false
  vnet2_use_vnet1_remote_gateway      = false
}

resource "null_resource" "server_login" {
  for_each = local.logins

  triggers = {
    id          = data.azurerm_mssql_managed_instance.main.id
    logins      = sha1(jsonencode(local.logins))
    force_rerun = 3
  }

  provisioner "local-exec" {
    command = join(" ", [
      "sqlcmd -G -h -1 -b -Q",
      "\"exec sp_create_login",
      "@user = '${each.key}', @role = '${each.value}';\"",
    ])
    environment = {
      SQLCMDSERVER = "${data.azurerm_mssql_managed_instance.main.fqdn}"
    }
  }
}
