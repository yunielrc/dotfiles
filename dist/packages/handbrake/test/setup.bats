load test_helper


@test 'should install handbrake' {
  dotf-i handbrake
  type -P ghb
  run dotf-i handbrake
  assert_success
  assert_output --partial 'handbrake currently installed'
}
