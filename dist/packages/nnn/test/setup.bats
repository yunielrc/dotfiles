load test_helper

@test 'should install nnn' {
  dotf-i nnn
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  type -P nnn
}
