load test_helper


@test 'should install nethogs' {
  dotf-i nethogs
  type -P nethogs
}
