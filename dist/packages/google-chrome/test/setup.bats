load test_helper

@test 'should install google chrome' {
  dotf-i google-chrome
  run type -P google-chrome
}
