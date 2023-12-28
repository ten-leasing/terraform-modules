locals {
  git_config_content = file(".git/config")
  remotes            = regexall("\\[remote (?:\"(?P<name>.*)\"\\]\\n.*url.*=.*(?P<url>https.*))", local.git_config_content)
}

output "remotes" {
  value = local.remotes
}
