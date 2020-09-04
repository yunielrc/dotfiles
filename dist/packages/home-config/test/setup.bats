load test_helper

@test 'should install home-config' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i home-config
  [[ -f ~/.gitconfig ]]
}
