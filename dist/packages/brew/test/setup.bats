load test_helper

@test 'should install brew' {
  dotf-i brew
  [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]
}
