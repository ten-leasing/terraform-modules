run "can_parse_git_remotes" {
  command = plan

  assert {
    condition     = output.remotes.remote == "https://example.com/repo"
    error_message = "remotes output not as expected"
  }
}
