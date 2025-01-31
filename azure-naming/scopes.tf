# https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules

locals {
  scopes = {
    global         = "global", # means only one resource of this type can exist globally (e.g. storage account)
    parent         = "parent",
    resource_group = "resource-group",
    region         = "region",
    subscription   = "subscription",
    tenant         = "tenant",
  }
}
