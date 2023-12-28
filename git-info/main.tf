locals {
  git_config_content = file(".git/config")
  remotes            = regexall("\\[remote (?:\"(?P<name>.*)\"\\]\\n.*url.*=.*(?P<url>https.*))", local.git_config_content)
}

output "remotes" {
  value = { for remote in module.git_info.remotes : remote.name => remote.url }
}
