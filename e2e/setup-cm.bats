load test_helper

@test 'should install desktop cm' {
  skip
  run bash ../dist/setup-cm desktop

  assert_success
  assert_output 'any'
}

