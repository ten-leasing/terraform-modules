locals {
  managed_identity_config = {
    abbrev = "id"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  managed_identity = format(
    "%s-%s",
    local.managed_identity_config.abbrev,
    var.PROJECT_KEY,
  )
}

output "managed-identity" { value = local.managed_identity }
