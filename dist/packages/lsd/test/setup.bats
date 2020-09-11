load test_helper

@test 'should install lsd' {
  dotf-i lsd
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  type -P lsd
}
