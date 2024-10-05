variable "VARIABLES" {
  type     = map(string)
  nullable = true
  default  = null
}

resource "github_actions_variable" "variables" {
  for_each = var.VARIABLES == null ? {} : var.VARIABLES

  repository = github_repository.self.name

  variable_name = each.key
  value         = each.value
}
