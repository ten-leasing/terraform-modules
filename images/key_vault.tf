data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "packer" {
  tenant_id           = data.azurerm_client_config.current.tenant_id
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = merge(var.tags, {})

  name                          = "${var.resource_name_prefix}-kv"
  sku_name                      = "standard"
  purge_protection_enabled      = false
  public_network_access_enabled = true

  enabled_for_deployment    = true
  enable_rbac_authorization = true

  # network_acls {
  #   ip_rules = [ "value" ]
  # }
}
