run "can_parse_git_remotes" {
  command = plan

  variables {
    git_dir = "../"
  }

  assert {
    condition     = length(output.remotes) > 1
    error_message = "remotes output not as expected"
  }
}
