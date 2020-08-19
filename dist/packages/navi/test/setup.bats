load test_helper


@test 'should install & configure navi' {
  type -P brew || skip
  bash ../setup

  type -P navi
}
