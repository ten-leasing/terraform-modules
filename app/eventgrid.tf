locals {
}

resource "azurerm_eventgrid_topic" "starlink" {
  name                = "${var.resource_name_prefix}-topic"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = merge(var.tags, {})

  local_auth_enabled = false
  # public_network_access_enabled = false
}

output "starlink_topic_endpoint" {
  value = azurerm_eventgrid_topic.starlink.endpoint
}
