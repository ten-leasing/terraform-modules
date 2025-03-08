locals {
  open_ai_abbreviation = "oai"
  open_ai = {
    abbrev = local.open_ai_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s%s",
      local.open_ai_abbreviation,
      var.ORG_KEY,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
  }

  translator_abbreviation = "trsl"
  translator = {
    abbrev = local.translator_abbreviation
    scope  = local.scopes.resource_group
    parent = local.resource_group
    name = format(
      "%s-%s%s",
      local.translator_abbreviation,
      var.ORG_KEY,
      var.WORKSPACE == "default" ? "" : "-${var.RESOURCE_NAME}",
    )
  }
}

output "open_ai" { value = local.open_ai }
output "translator" { value = local.translator }
