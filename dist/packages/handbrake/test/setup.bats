load test_helper


@test 'should install handbrake & config' {
  bash ../setup

  type -P ghb

  run bash ../setup

  assert_success
  assert_output --partial 'handbrake currently installed'
}
