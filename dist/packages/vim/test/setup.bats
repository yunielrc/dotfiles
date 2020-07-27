load test_helper

@test 'should install vim' {
  apt-u
  run env PKG_CONTENT="${PKGS_PATH}/vim/content" bash ../setup

  assert_success
  assert_output --partial "'/home/user/.vimrc' -> '/home/user/.vim_runtime/vimrcs/basic.vim"
  type -P vim
}