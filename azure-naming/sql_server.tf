locals {
  mssql_server_abbreviation = "sql"
  mssql_server = {
    abbrev = local.mssql_server_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.mssql_server_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "mssql_server" { value = local.mssql_server }
