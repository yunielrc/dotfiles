load test_helper

@test 'should install iotop' {
  dotf-i iotop
  type -P iotop
}
