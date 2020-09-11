load test_helper

@test 'should install fzf' {
  dotf-i fzf
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  type -P fzf
}
