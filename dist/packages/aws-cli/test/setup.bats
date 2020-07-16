load test_helper


@test 'should install aws cli & config' {
  bash ../setup

  type -P aws

  run bash ../setup

  assert_success
  assert_output --partial 'aws cli currently installed'
}
