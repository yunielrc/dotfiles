load test_helper

@test 'should install aws-cli' {
  dotf-i aws-cli
  type -P aws
}
