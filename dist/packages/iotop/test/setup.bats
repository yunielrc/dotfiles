load test_helper

@test 'should install iotop & config' {
  apt-u
  dotf-i iotop
  type -P iotop
}
