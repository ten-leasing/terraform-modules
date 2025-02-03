locals {
  public_ip_config = {
    abbrev = "pip"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  public_ip = format(
    "%s-%s",
    local.public_ip_config.abbrev,
    var.RESOURCE_NAME,
  )
}

output "public_ip" { value = local.public_ip }
