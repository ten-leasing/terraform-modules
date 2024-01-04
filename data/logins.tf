locals {
}

variable "logins" {
  description = "Map of login names and list of their roles"
  type        = map(string)
}

resource "null_resource" "server_login" {
  for_each = var.logins

  triggers = {
    id          = azurerm_mssql_managed_instance.self.id
    logins      = sha1(jsonencode(var.logins))
    force_rerun = 0
  }

  provisioner "local-exec" {
    command = join("", [
      "sqlcmd -G -h -1 -Q \"",
      "CREATE LOGIN [${each.key}] FROM EXTERNAL PROVIDER;",
      "ALTER SERVER ROLE ${each.value} ADD MEMBER [${each.key}];",
      "\"",
    ])
    environment = {
      SQLCMDSERVER = "${azurerm_mssql_managed_instance.self.fqdn}"
    }
  }
}
