locals {
  route_table_abbreviation = "rt"
  route_table = {
    abbrev = local.route_table_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s%s%s",
      local.route_table_abbreviation,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "route_table" { value = local.route_table }
