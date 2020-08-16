load test_helper

@test 'should install core-config' {
  PKG_CONTENT="$(realpath ./fixtures)" run bash ../setup

  assert_success
  assert_line --index 0 --regexp "mkdir: created directory '/home/\w+/.ssh'"
  assert_line --index 1 --regexp "'/home/\w+/.ssh/config' -> '/home/\w+/dotfiles/dist/packages/core-config/test/fixtures/.ssh/config'"
  assert_line --index 2 --regexp "'/home/\w+/.inputrc' -> '/home/\w+/dotfiles/dist/packages/core-config/test/fixtures/.inputrc'"
  assert_line --index 3 --regexp "'/home/\w+/.gitconfig' -> '/home/\w+/dotfiles/dist/packages/core-config/test/fixtures/.gitconfig'"
}
