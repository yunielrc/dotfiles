load test_helper

@test 'should install shfmt' {
  run type -P shfmt
  assert_failure

  dotf-i shfmt
  type -P shfmt
}
