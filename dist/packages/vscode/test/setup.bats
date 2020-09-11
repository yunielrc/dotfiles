load test_helper

@test 'should install vscode & config' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i vscode
  type -P code
}
