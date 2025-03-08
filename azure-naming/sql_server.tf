locals {
  sql_server_abbreviation = "sql"
  sql_server = {
    abbrev = local.sql_server_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s-%s-%s%s",
      local.sql_server_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "sql_server" { value = local.sql_server }
