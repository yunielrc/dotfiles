load test_helper

@test 'should install brew config' {
  export BASH_PLUGINS_DIR=/tmp
  run bash ../setup

  [[ -L /tmp/brew.plugin.bash && -f /tmp/brew.plugin.bash ]]

  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  brew install hello

  run which hello
  assert_output '/home/linuxbrew/.linuxbrew/bin/hello'

  run bash ../setup
  assert_output --regexp 'brew currently installed'
}
