load test_helper

@test 'should install insomnia' {
  dotf-i insomnia
  type -P insomnia
}
