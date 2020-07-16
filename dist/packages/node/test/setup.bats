load test_helper


@test 'should install node, yarn & config' {
  bash ../setup

  type -P node
  type -P yarn

  run bash ../setup

  assert_success
  assert_output --partial 'node currently installed'
}
