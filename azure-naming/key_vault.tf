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
}

output "key_vault" { value = local.key_vault }
