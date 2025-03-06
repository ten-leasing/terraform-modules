locals {
  private_endpoint_abbreviation = "pep"
  private_endpoint = {
    abbrev = local.private_endpoint_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s",
      local.private_endpoint_abbreviation,
      var.RESOURCE_NAME,
    )
  }
}

output "private_endpoint" { value = local.private_endpoint }
