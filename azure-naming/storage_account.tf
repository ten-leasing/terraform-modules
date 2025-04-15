locals {
  storage_account_abbreviation = "st"
  storage_account = {
    abbrev = local.storage_account_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = replace(
      format(
        "%s%s%s%s",
        local.storage_account_abbreviation,
        var.ORG_KEY,
        var.RESOURCE_NAME,
        var.WORKSPACE == "default" ? "" : "${var.WORKSPACE}"
      ), "-", ""
    )
  }
}

output "storage_account" { value = local.storage_account }
