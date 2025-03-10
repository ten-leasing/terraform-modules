run "private-dns-resolver" {
  command = plan

  assert {
    condition = local.private_dns_resolver.name == format(
      "%s-%s%s%s",
      local.private_dns_resolver.abbrev,
      var.ORG_KEY,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "private-dns-resolver naming convention is incorrect"
  }

  assert {
    condition = local.private_dns_resolver_inbound.name == format(
      "%s%s%s",
      local.private_dns_resolver_inbound.abbrev,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "private-dns-resolver-inbound naming convention is incorrect"
  }

  assert {
    condition = local.private_dns_resolver_outbound.name == format(
      "%s%s%s",
      local.private_dns_resolver_outbound.abbrev,
      var.RESOURCE_NAME == "" ? "" : "-${var.RESOURCE_NAME}",
      var.WORKSPACE == "default" ? "" : "-${var.WORKSPACE}"
    )
    error_message = "private-dns-resolver-outbound naming convention is incorrect"
  }
}
