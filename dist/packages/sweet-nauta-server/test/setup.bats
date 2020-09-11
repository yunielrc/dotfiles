load test_helper

@test 'should install sweet-nauta-server' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i sweet-nauta-server
  [[ -f /opt/sweet-nauta-server/bin/login ]]
}
