locals {
  log_analytics_workspace_abbreviation = "log"
  log_analytics_workspace = {
    abbrev = local.log_analytics_workspace_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s",
      local.log_analytics_workspace_abbreviation,
      var.RESOURCE_NAME,
    )
  }
}

output "log_analytics_workspace" { value = local.log_analytics_workspace }
