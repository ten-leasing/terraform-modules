run "event-grid" {
  command = plan

  assert {
    condition = local.event_grid_system_topic.name == format(
      "%s-%s%s-%s%s",
      local.event_grid_system_topic.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.LOCATION,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "event-grid system topic naming convention is incorrect"
  }

  assert {
    condition = local.event_grid_topic.name == format(
      "%s-%s%s-%s%s",
      local.event_grid_topic.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.LOCATION,
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "event-grid topic naming convention is incorrect"
  }
}
