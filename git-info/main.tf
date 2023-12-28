locals {
  git_config_content = file(".git/config")
  remotes            = regex("\\[remote \"(.*)\"\\]\\n.*url.*=.*(https.*)", local.git_config_content)
  all_remote         = regexall("\\[remote \"(.*)\"\\]\\n.*url.*=.*(https.*)", local.git_config_content)
}

output "git_remotes" {
  value = local.remotes
}

output "git_all_remotes" {
  value = local.remotes
}
