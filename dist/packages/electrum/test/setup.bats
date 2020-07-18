load test_helper


@test 'should install electrum & config' {
  bash ../setup

  assert_output ''

  type -P electrum
}
