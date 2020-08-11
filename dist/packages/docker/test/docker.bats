load test_helper


@test 'should install docker-ubuntu' {
  [[ "$RUN_ON_DOCKER" == true ]] && skip
  bash ../setup

  type -P docker
  type -P docker-compose

  sudo docker run hello-world

  bash ../setup | grep -q 'docker currently installed'
}
