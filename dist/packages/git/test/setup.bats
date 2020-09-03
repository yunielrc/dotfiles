load test_helper

@test 'should install git' {
  run dotf-i git --force

  assert_success
  assert_output --partial "DONE. Installing package git"

  type -P git
  [[ -f ~/.gitconfig  ]]
}
