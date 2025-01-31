run "web-pubsub" {
  command = plan

  assert {
    condition = local.web_pubsub == format(
      "%s-%s",
      local.web_pubsub_config.abbrev,
      var.PROJECT_KEY,
    )
    error_message = "web-pubsub naming convention is incorrect"
  }
}
