load test_helper


@test 'should install nethogs & config' {
  apt-u
  bash ../setup

  type -P nethogs

  run bash ../setup

  assert_success
  assert_output --partial 'nethogs currently installed'
}
