locals {
  managed_grafana_abbreviation = "amg"
  managed_grafana = {
    abbrev = local.managed_grafana_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.managed_grafana_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "managed_grafana" { value = local.managed_grafana }
