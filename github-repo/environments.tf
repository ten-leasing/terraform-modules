variable "ENVIRONMENTS" {
  type = map(object({
    admin_bypass        = optional(bool)
    prevent_self_review = optional(bool)
    reviewers = optional(object({
      teams = optional(set(number))
      users = optional(set(number))
    }))
    variables = optional(map(string))
    secrets   = optional(map(string))
  }))
  nullable = true
  default  = null
}

module "environment" {
  source = "../github-repo-environment"

  for_each = var.ENVIRONMENTS == null ? {} : var.ENVIRONMENTS

  GITHUB_REPOSITORY_NAME = github_repository.self.name
  NAME                   = each.key
  ADMIN_BYPASS           = each.value.admin_bypass
  PREVENT_SELF_REVIEW    = each.value.prevent_self_review
  REVIEWERS              = each.value.reviewers
  VARIABLES              = each.value.variables
  SECRETS                = each.value.secrets
}

output "environment" { value = module.environment }
