locals {
  managed_grafana_config = {
    abbrev = "amg"
    scope  = local.scopes.global
    parent = null
  }

  managed_grafana = format(
    "%s-%s",
    local.managed_grafana_config.abbrev,
    var.PROJECT_KEY,
  )
}

output "managed-grafana" { value = local.managed_grafana }
