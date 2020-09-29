load test_helper

@test 'should install net-tools' {
  dotf-i net-tools
  type -P netstat
}
