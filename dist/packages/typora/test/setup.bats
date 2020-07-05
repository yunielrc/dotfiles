load test_helper


@test 'should install typora & config' {
  bash ../setup

  run type -P typora
  assert_success

  run bash ../setup
  assert_success
  assert_output --regexp 'typora currently installed'
}
