locals {
  web_pubsub_config = {
    abbrev = "wps"
    scope  = local.scopes.global
  }

  web_pubsub = format(
    "%s-%s",
    local.web_pubsub_config.abbrev,
    var.PROJECT_KEY,
  )
}

output "web-pubsub" { value = local.web_pubsub }
