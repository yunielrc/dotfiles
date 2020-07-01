load test_helper

@test 'should install brew config' {
  run bash ../setup

  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  brew install hello

  run which hello
  assert_output '/home/linuxbrew/.linuxbrew/bin/hello'

  run bash ../setup
  assert_output --regexp 'brew currently installed'
}
