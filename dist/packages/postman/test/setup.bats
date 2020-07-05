load test_helper

@test 'should install postman & config' {
  bash ../setup

  [[ -f '/opt/Postman/Postman' ]]

  run file '/opt/Postman/app/Postman'

  assert_success
  assert_output --partial 'ELF 64-bit LSB executable'

  [[ -f '/usr/share/applications/Postman.desktop' ]]

  run bash ../setup

  assert_success
  assert_output --partial 'Postman currently installed'
}
