locals {
  git_config_content = file(".git/config")
  remotes            = regex("\\[remote \"(.*)\"\\]\\n.*url.*=.*(https.*)", local.git_config_content)
}

output "git_remotes" {
  value = local.remotes
}
