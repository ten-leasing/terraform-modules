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
    var.PROJECT_KEY,
    var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
  )
}

output "static-web-app" { value = local.static_web_app }
