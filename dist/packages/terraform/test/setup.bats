load test_helper

@test 'should install terraform' {
  dotf-i terraform
  type -P terraform
}
