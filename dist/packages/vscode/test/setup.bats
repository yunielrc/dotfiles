load test_helper


@test 'should install vscode & config' {
  bash ../setup

  run type -P code

  assert_success
  assert_output --regexp '.*/code$'

  run bash ../setup

  assert_success
  assert_output --regexp 'vscode currently installed'
}
