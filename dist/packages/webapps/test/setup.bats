load test_helper

teardown() {
  rm ~/.local/share/applications/webapps
}

@test 'should install webapps config' {
  run env PKG_CONTENT="${PKGS_PATH}/webapps/content" bash ../setup

  assert_success
  assert_output "'/home/ubuntu/.local/share/applications/webapps' -> '/home/ubuntu/dotfiles/dist/packages/webapps/content/applications/webapps'"

  [[ -L /home/ubuntu/.local/share/applications/webapps && -d /home/ubuntu/.local/share/applications/webapps ]]
}
