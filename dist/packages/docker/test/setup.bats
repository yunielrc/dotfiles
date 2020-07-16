load test_helper


@test 'should install docker & config' {
  skip
  bash ../setup

  type -P docker
  type -P docker-compose

  # docker run hello-world

  run bash ../setup

  assert_success
  assert_output --partial 'docker currently installed'
}
