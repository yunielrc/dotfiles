load test_helper

@test 'should install vagrant' {
  dotf-i vagrant
  type -P vagrant
}
