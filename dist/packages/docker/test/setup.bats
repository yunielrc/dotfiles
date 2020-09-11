load test_helper


@test 'should install docker' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i docker
  type -P docker
  type -P docker-compose
  sudo docker run hello-world
}
