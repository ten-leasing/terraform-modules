run "cosmosdb" {
  command = plan

  assert {
    condition = local.cosmosdb_nosql_account.name == format(
      "%s-%s%s%s",
      local.cosmosdb_nosql_account.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "cosmosdb-nosql-account naming convention is incorrect"
  }

  assert {
    condition = local.cosmosdb_database.name == format(
      "%s%s%s",
      local.cosmosdb_database.abbrev,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "cosmosdb-database naming convention is incorrect"
  }

}
