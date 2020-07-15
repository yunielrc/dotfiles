load test_helper

teardown() {
  rm ~/.local/share/{applications,icons}/webapps
}

@test 'should install webapps config' {
  run env PKG_CONTENT="${PKGS_PATH}/webapps/content" bash ../setup

  assert_success
  assert_output "INFO> Symbolic link created: '/home/user/.local/share/applications/webapps' -> '/home/user/dotfiles/dist/packages/webapps/content/applications/webapps'
INFO> Symbolic link created: '/home/user/.local/share/icons/webapps' -> '/home/user/dotfiles/dist/packages/webapps/content/icons/webapps'"

  [[ -L /home/user/.local/share/icons/webapps && -d /home/user/.local/share/icons/webapps ]]
  [[ -L /home/user/.local/share/applications/webapps && -d /home/user/.local/share/applications/webapps ]]

  run env PKG_CONTENT="${PKGS_PATH}/webapps/content" bash ../setup
  assert_output "INFO> Directory: '/home/user/.local/share/applications/webapps' already exists
INFO> Directory: '/home/user/.local/share/icons/webapps' already exists"
}
