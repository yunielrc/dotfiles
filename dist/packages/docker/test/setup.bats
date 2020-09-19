load test_helper

teardown_file() {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && return
  if [[ -f /etc/systemd/system/docker.service.d/http-proxy.conf ]]; then
    sudo rm -f /etc/systemd/system/docker.service.d/http-proxy.conf
    sudo systemctl daemon-reload
    sudo systemctl restart docker.service
  fi
}

@test 'should install docker' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i docker
  type -P docker
  type -P docker-compose
  sudo docker run hello-world
}
