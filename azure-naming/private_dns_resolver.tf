locals {
  private_dns_resolver_config = {
    abbrev = "dnspr"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  private_dns_resolver = format(
    "%s-%s",
    local.private_dns_resolver_config.abbrev,
    var.PROJECT_KEY,
  )

  private_dns_resolver_inbound_config = {
    abbrev = "in"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  private_dns_resolver_inbound = format(
    "%s-%s",
    local.private_dns_resolver_inbound_config.abbrev,
    var.PROJECT_KEY,
  )

  private_dns_resolver_outbound_config = {
    abbrev = "out"
    scope  = local.scopes.resource_group
    parent = local.resource_group_config
  }

  private_dns_resolver_outbound = format(
    "%s-%s",
    local.private_dns_resolver_outbound_config.abbrev,
    var.PROJECT_KEY,
  )
}

output "private_dns_resolver" { value = local.private_dns_resolver }
output "private_dns_inbound" { value = local.private_dns_resolver_inbound }
output "private_dns_outbound" { value = local.private_dns_resolver_outbound }
