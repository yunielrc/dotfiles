load test_helper

@test 'should install network-config' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip

  dotf-i network-config
}
