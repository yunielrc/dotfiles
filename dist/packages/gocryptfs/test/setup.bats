load test_helper

@test 'should install gocryptfs' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i gocryptfs
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  type -P gocryptfs
}
