load test_helper

@test 'should install lsof' {
  dotf-i lsof --force
  type -P lsof
}
