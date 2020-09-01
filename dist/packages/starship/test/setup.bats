load test_helper


@test 'should install & configure starship' {
  type -P brew || skip
  dotf-i starship

  type -P starship
}
