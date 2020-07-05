load test_helper


@test 'should install insomnia & config' {
  skip
  bash ../setup

  run type -P insomnia
  assert_success

  run bash ../setup
  assert_success
  assert_output --partial 'insomnia currently installed'
}
