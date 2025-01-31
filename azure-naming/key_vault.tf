locals {
  key_vault_config = {
    abbrev = "kv"
    scope  = local.scopes.global
    parent = null
  }

  key_vault = format(
    "%s-%s",
    local.key_vault_config.abbrev,
    var.PROJECT_KEY,
  )
}

output "key-vault" { value = local.key_vault }
