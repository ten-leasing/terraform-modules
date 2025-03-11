locals {
  key_vault_abbreviation = "kv"
  key_vault = {
    abbrev = local.key_vault_abbreviation
    scope  = local.scopes.global
    parent = null
    name = format(
      "%s-%s%s%s",
      local.key_vault_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }

  key_vault_secret_abbreviation = "kvs"
  key_vault_secret = {
    abbrev = local.key_vault_secret_abbreviation
    scope  = local.scopes.parent
    parent = local.key_vault
    name = format(
      "%s-%s%s%s",
      local.key_vault_secret_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "key_vault" { value = local.key_vault }
output "key_vault_secret" { value = local.key_vault_secret }
