load test_helper

@test 'should install iftop' {
  dotf-i iftop
  type -P iftop
}
