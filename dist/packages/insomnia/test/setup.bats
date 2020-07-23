load test_helper


@test 'should install insomnia & config' {
  bash ../setup
  type -P insomnia
}
