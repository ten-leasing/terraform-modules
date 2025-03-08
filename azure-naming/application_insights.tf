locals {
  application_insights_abbreviation = "appi"
  application_insights = {
    abbrev = local.application_insights_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s%s",
      local.application_insights_abbreviation,
      var.ORG_KEY,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
  }
}

output "application_insights" { value = local.application_insights }
