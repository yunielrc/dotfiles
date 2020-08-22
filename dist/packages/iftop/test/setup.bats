load test_helper

@test 'should install iftop & config' {
  apt-u
  dotf-i iftop
  type -P iftop
}
