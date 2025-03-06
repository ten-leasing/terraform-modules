locals {
  powerbi_embedded_abbreviation = "pbi"
  powerbi_embedded = {
    abbrev = local.powerbi_embedded_abbreviation
    scope  = local.scopes.region
    parent = local.resource_group
    name = format(
      "%s%s%s%s",
      local.powerbi_embedded_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME,
      var.LOCATION,
    )
  }
}

output "powerbi_embedded" { value = local.powerbi_embedded }
