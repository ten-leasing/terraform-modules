locals {
  event_hub_namespace_abbreviation = "evhns"
  event_hub_namespace = {
    abbrev = local.event_hub_namespace_abbreviation
    scope  = local.scopes.global
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.event_hub_namespace_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }

  event_hub_abbreviation = "evh"
  event_hub = {
    abbrev = local.event_hub_abbreviation
    scope  = local.scopes.parent
    parent = local.event_hub_namespace
    name = format(
      "%s%s%s",
      local.event_hub_abbreviation,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "event_hub_namespace" { value = local.event_hub_namespace }
output "event_hub" { value = local.event_hub }
