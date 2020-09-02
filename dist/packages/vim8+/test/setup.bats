load test_helper

@test 'should install vim8+' {
  run dotf-i vim8+

  assert_success
  assert_output --partial "DONE. Installing package vim8+"

  type -P vim
  [[ -d ~/.vim  ]]
  [[ -f ~/.vimrc ]]
}
