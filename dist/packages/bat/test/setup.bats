load test_helper

@test 'should install bandwhich' {
  dotf-i bandwhich
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  type -P bandwhich
}
