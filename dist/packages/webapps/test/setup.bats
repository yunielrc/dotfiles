load test_helper

teardown() {
  rm ~/.local/share/applications/webapps
}

@test 'should install webapps config' {
  run env PKG_CONTENT="${PKGS_PATH}/webapps/content" bash ../setup

  assert_success
  assert_output "INFO> Symbolic link created: '/home/user/.local/share/applications/webapps' -> '/home/user/dotfiles/dist/packages/webapps/content/applications/webapps'"

  [[ -L /home/user/.local/share/applications/webapps && -d /home/user/.local/share/applications/webapps ]]

  run env PKG_CONTENT="${PKGS_PATH}/webapps/content" bash ../setup
  assert_output "INFO> Directory: '/home/user/.local/share/applications/webapps' already exists"
}
