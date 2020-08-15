load test_helper

@test 'should install bandwhich & config' {
  type -P brew || skip
  bash ../setup

  type -P bandwhich
}
