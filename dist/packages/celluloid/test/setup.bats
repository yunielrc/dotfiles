load test_helper


@test 'should install celluloid' {
  dotf-i celluloid
  type -P celluloid
}
