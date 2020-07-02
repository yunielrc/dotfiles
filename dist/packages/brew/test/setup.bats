load test_helper

@test 'should install brew & config' {
  run bash ../setup

  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

  run type -P brew

  assert_success
  assert_output --regexp '.*/brew$'

  brew install hello

  run type -P hello

  assert_success
  assert_output --regexp '.*/hello$'

  run bash ../setup

  assert_success
  assert_output --regexp 'brew currently installed'
}
