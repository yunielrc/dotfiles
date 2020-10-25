load test_helper

@test 'should install shadowsocks-rust-client' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i shadowsocks-rust-client
  [[ -n "$(sudo docker ps --all --quiet --filter name=ssclient)" ]]
}
