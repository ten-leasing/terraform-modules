locals {
  managed_identity_abbreviation = "id"
  managed_identity = {
    abbrev = local.managed_identity_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s",
      local.managed_identity_abbreviation,
      var.RESOURCE_NAME,
    )
  }
}

output "managed_identity" { value = local.managed_identity }
