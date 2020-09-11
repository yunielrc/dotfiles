load test_helper

@test 'should install git' {
  dotf-i git --force
  type -P git
  [[ -f ~/.gitconfig  ]]
}
