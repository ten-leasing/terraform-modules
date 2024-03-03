variable "certificate_initial_validity_period_in_months" {
  type    = number
  default = 12
}

# The ID of the Key Vault Secret. Stored secret is the Base64 encoding of a JSON Object that which is encoded in UTF-8
# If your certificate is stored in Azure Key Vault - this can be sourced from the secret_id property on the azurerm_key_vault_certificate resource
resource "azurerm_key_vault_certificate" "vm" {
  provider     = azurerm.current
  key_vault_id = var.key_vault_id
  name         = "${var.resource_name_prefix}-cert"

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    key_properties {
      key_type   = "RSA"
      key_size   = 2048
      exportable = true
      reuse_key  = true
    }

    lifetime_action {
      trigger {
        days_before_expiry = 30
      }
      action {
        action_type = "AutoRenew"
      }
    }

    x509_certificate_properties {
      subject            = "CN="
      validity_in_months = var.certificate_initial_validity_period_in_months
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]
    }
  }
}
