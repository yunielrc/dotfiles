load test_helper

@test 'should install navi' {
  dotf-i navi
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  type -P navi
}
