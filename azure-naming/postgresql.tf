locals {
  postgresql_server_abbreviation = "psql"
  postgresql_server = {
    abbrev = local.postgresql_server_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.postgresql_server_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "postgresql_server" { value = local.postgresql_server }
