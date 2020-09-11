load test_helper

@test 'should install & configure starship' {
  dotf-i starship
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  type -P starship
}
