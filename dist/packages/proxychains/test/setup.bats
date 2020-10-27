load test_helper

@test 'should install proxychains' {
  dotf-i proxychains
  type -P proxychains
}
