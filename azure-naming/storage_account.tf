locals {
  storage_account_config = {
    abbrev = "st"
    scope  = local.scopes.global
    parent = null
  }

  storage_account = format(
    "%s%s%s%s",
    local.storage_account_config.abbrev,
    var.ORG_KEY,
    var.PROJECT_KEY,
    var.WORKSPACE == "default" ? "" : "${var.WORKSPACE}"
  )
}

output "storage-account" { value = local.storage_account }
