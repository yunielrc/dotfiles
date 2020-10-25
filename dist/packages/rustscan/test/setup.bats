load test_helper

@test 'should install rustscan' {
  dotf-i rustscan
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  type -P rustscan
}
