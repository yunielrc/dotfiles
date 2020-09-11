load test_helper


@test 'should install node' {
  dotf-i node
  type -P node
  type -P yarn
}
