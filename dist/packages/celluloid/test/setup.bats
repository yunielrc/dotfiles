load test_helper


@test 'should install celluloid & config' {
  bash ../setup

  type -P celluloid
}
