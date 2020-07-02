load test_helper

@test 'should install google chrome & config' {
  run bash ../setup

  run type -P google-chrome

  assert_success
  assert_output --regexp '.*/google-chrome$'

  run bash ../setup

  assert_success
  assert_output --regexp 'google-chrome currently installed'
}
