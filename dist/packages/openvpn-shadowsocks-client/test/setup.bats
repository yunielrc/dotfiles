load test_helper

@test 'should install openvpn-shadowsocks-client' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i openvpn-shadowsocks-client
  [[ -n "$(sudo docker ps --all --quiet --filter name=ssclient)" ]]
}
