load test_helper

@test 'should install lsd' {
  type -P brew || skip
  bash ../setup

  type -P lsd
}
