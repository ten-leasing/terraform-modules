locals {
  private_endpoint_abbreviation = "pep"
  private_endpoint = {
    abbrev = local.private_endpoint_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.private_endpoint_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "private_endpoint" { value = local.private_endpoint }
