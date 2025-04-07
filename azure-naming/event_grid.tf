locals {
  event_grid_system_topic_abbreviation = "evst"
  event_grid_system_topic = {
    abbrev = local.event_grid_topic_abbreviation
    scope  = local.scopes.region
    parent = local.resource_group
    name = format(
      "%s-%s%s-%s%s",
      local.event_grid_topic_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.LOCATION,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }

  event_grid_topic_abbreviation = "evgt"
  event_grid_topic = {
    abbrev = local.event_grid_topic_abbreviation
    scope  = local.scopes.region
    parent = local.resource_group
    name = format(
      "%s-%s%s-%s%s",
      local.event_grid_topic_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.LOCATION,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }

  event_grid_subscription_abbreviation = "evgs"
  event_grid_subscription = {
    abbrev = local.event_grid_subscription_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s%s%s",
      local.event_grid_subscription_abbreviation,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
  }
}

output "event_grid_system_topic" { value = local.event_grid_system_topic }
output "event_grid_topic" { value = local.event_grid_topic }
output "event_grid_subscription" { value = local.event_grid_subscription }
