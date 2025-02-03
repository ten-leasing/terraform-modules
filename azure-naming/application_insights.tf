locals {
  application_insights_config = {
    abbrev = "appi"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  application_insights = format(
    "%s-%s",
    local.application_insights_config.abbrev,
    var.RESOURCE_NAME,
  )
}

output "application_insights" { value = local.application_insights }
