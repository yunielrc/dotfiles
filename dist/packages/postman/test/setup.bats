load test_helper

@test 'should install postman & config' {
  run bash ../setup

  [[ -f '/opt/Postman/Postman' ]]

  assert_success

  run bash ../setup

  assert_success
  assert_output --regexp 'Postman currently installed'
}
