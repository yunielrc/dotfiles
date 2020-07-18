load test_helper


@test 'should install nethogs & config' {
  apt-u
  bash ../setup

  type -P nethogs
}
