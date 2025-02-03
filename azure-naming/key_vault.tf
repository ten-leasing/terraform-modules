locals {
  key_vault_config = {
    abbrev = "kv"
    scope  = local.scopes.global
    parent = null
  }

  key_vault = format(
    "%s-%s-%s%s",
    local.key_vault_config.abbrev,
    var.ORG_KEY,
    var.RESOURCE_NAME,
    var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
  )
}

output "key_vault" { value = local.key_vault }
