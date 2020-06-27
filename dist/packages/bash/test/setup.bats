load test_helper


@test 'should install bash config' {
  run bash ../setup

  assert_success
  assert_output "INFO> Symbolic link created:  '/root/.bashc' -> '/root/dotfiles/dist/packages/bash/content/.bashc'
INFO> Added: '~/.bashc/init' to '/root/.bashrc'"
  #---
  run grep '~/.bashc/init' ~/.bashrc
  assert_output --regexp '~/.bashc/init'
  #---
}
