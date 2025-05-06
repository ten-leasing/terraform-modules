locals {
  monitor_workspace_abbreviation = "monw"
  monitor_workspace = {
    abbrev = local.monitor_workspace_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.monitor_workspace_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "monitor_workspace" { value = local.monitor_workspace }
