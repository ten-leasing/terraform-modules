locals {
  managed_grafana_config = {
    abbrev = "amg"
    scope  = local.scopes.global
    parent = null
  }

  managed_grafana = format(
    "%s-%s-%s%s",
    local.managed_grafana_config.abbrev,
    var.ORG_KEY,
    var.RESOURCE_NAME,
    var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
  )
}

output "managed_grafana" { value = local.managed_grafana }
