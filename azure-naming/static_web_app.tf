locals {
  static_web_app_config = {
    abbrev = "stapp"
    scope  = local.scopes.global
    parent = null
  }

  static_web_app = format(
    "%s-%s-%s%s",
    local.static_web_app_config.abbrev,
    var.ORG_KEY,
    var.RESOURCE_NAME,
    var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
  )
}

output "static_web_app" { value = local.static_web_app }
