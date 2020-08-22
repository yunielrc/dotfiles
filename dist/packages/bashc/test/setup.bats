load test_helper

setup() {
  [[ -d ~/.bashc ]] && rm -r ~/.bashc
  [[ -f ~/.bashrc ]] && rm ~/.bashrc
}

@test 'should install bash config' {
  run env PKG_PATH="${PKGS_PATH}/bashc" PKG_CONTENT="${PKGS_PATH}/bashc/content" bash ../setup

  assert_success
  assert_output "INFO> Symbolic link created: '/home/ubuntu/.bashc' -> '/home/ubuntu/dotfiles/dist/packages/bashc/content/.bashc'
INFO> Added: '~/.bashc/init' to '/home/ubuntu/.bashrc'"

  [[ -L /home/ubuntu/.bashc && -d /home/ubuntu/.bashc ]]

  run grep '~/.bashc/init' ~/.bashrc
  assert_output --regexp '~/.bashc/init && bashc::main$'

  run env PKG_PATH="${PKGS_PATH}/bashc" PKG_CONTENT="${PKGS_PATH}/bashc/content" bash ../setup

  assert_success
  assert_output "INFO> Directory: '/home/ubuntu/dotfiles/dist/packages/bashc/content/.bashc' already exists
INFO> '~/.bashc/init' Already added to '/home/ubuntu/.bashrc'"
}
