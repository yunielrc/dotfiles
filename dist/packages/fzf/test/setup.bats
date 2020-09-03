load test_helper

@test 'should install fzf' {
  type -P brew || skip
  dotf-i fzf
  type -P fzf
}
