run "event-hub" {
  command = plan

  assert {
    condition = local.event_hub_namespace.name == format(
      "%s-%s%s%s",
      local.event_hub_namespace.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "event-hub namespace naming convention is incorrect"
  }

  assert {
    condition = local.event_hub.name == format(
      "%s%s%s",
      local.event_hub.abbrev,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "event-hub naming convention is incorrect"
  }
}
