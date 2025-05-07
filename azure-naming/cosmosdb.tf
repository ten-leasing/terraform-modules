locals {
  cosmosdb_nosql_account_abbreviation = "cosno"
  cosmosdb_nosql_account = {
    abbrev = local.cosmosdb_nosql_account_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.cosmosdb_nosql_account_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "cosmosdb_nosql_account" { value = local.cosmosdb_nosql_account }
