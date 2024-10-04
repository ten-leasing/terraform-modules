variable "ENVIRONMENTS" {
  type = map(object({
    variables = optional(map(string))
  }))
  nullable = true
  default  = null
}

module "environment" {
  source = "../github-repo-environment"

  for_each = var.ENVIRONMENTS == null ? {} : var.ENVIRONMENTS

  GITHUB_REPOSITORY_NAME = github_repository.self.name
  NAME                   = each.key
  VARIABLES              = each.value.variables == null ? null : each.value.variables
}

output "environment" { value = module.environment }
