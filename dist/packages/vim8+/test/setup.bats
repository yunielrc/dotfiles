load test_helper

@test 'should install vim8+' {
  dotf-i vim8+
  type -P vim
  [[ -d ~/.vim  ]]
  [[ -f ~/.vimrc ]]
}
