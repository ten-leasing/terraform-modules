locals {
  powerbi_embedded_abbreviation = "pbi"
  powerbi_embedded = {
    abbrev = local.powerbi_embedded_abbreviation
    scope  = local.scopes.region
    parent = local.resource_group
    name = format(
      "%s%s%s",
      local.powerbi_embedded_abbreviation,
      var.LOCATION,
      var.RESOURCE_NAME,
    )
  }
}

output "powerbi_embedded" { value = local.powerbi_embedded }
