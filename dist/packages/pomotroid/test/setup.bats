load test_helper

@test 'should install pomotroid' {
  dotf-i pomotroid
  type -P pomotroid
}
