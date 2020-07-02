load test_helper

@test 'should install google chrome & config' {
  run bash ../setup

  run type -P google-chrome

  assert_success
  assert_output --regexp '.*/google-chrome$'
}

@test 'should not install google chrome if already installed' {
  run bash ../setup
  run bash ../setup

  assert_failure
  assert_output --regexp 'google-chrome currently installed'
}
