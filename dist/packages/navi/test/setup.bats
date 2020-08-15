load test_helper


@test 'should install fzf' {
  type -P brew || skip
  bash ../setup

  type -P navi
}
