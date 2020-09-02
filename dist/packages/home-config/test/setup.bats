load test_helper

@test 'should install home-config' {
  dotf-i home-config
  [[ -f ~/.gitconfig ]]
}
