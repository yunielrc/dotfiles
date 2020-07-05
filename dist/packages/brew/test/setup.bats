load test_helper

@test 'should install brew & config' {
  bash ../setup &> /dev/null

  [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]
  [[ -f /home/linuxbrew/.linuxbrew/bin/patchelf ]]

  run bash ../setup

  assert_success
  assert_output --partial 'brew currently installed'
}
