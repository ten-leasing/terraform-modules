locals {
  route_table_config = {
    abbrev = "rt"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  route_table = format(
    "%s-%s",
    local.route_table_config.abbrev,
    var.RESOURCE_NAME,
  )
}

output "route-table" { value = local.route_table }
