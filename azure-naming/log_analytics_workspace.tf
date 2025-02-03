locals {
  log_analytics_workspace_config = {
    abbrev = "log"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  log_analytics_workspace = format(
    "%s-%s",
    local.log_analytics_workspace_config.abbrev,
    var.PROJECT_KEY,
  )
}

output "log_analytics_workspace" { value = local.log_analytics_workspace }
