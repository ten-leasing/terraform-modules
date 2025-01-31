locals {
  application_insights_config = {
    abbrev = "appi"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  application_insights = format(
    "%s-%s",
    local.application_insights_config.abbrev,
    var.PROJECT_KEY,
  )
}

output "application-insights" { value = local.application_insights }
