load test_helper


@test 'should install typora' {
  dotf-i typora
  type -P typora
  run dotf-i typora
  assert_output --partial 'typora currently installed'
}
