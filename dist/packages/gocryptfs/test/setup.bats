load test_helper


@test 'should install gocryptfs' {
  dotf-i gocryptfs
  type -P gocryptfs
}
