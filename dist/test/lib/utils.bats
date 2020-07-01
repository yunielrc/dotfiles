load test_helper

setup() {
  TMP_DIR="$(mktemp -d)"
  DIST_PATH="$(realpath ./fixtures)"
  BASH_PLUGINS_DIR="$TMP_DIR"
  BASH_GEN_SETTINGS_FILE="${TMP_DIR}/settings_gen.bash"
}

@test "plugin doesn't exists" {
    run install_plugin 'plugin1'

    assert_failure
    assert_output --regexp "ERROR> Setting bash plugin: plugin1, plugin doesn't exist: .*/dist/test/lib/fixtures/packages/plugin1/content/plugin1.plugin.bash"
}

@test "plugin dir doesn't exists" {
    BASH_PLUGINS_DIR=/tmp/123456654321
    run install_plugin 'brew'

    assert_failure
    assert_output "INFO> Setting bash plugin: brew
ERROR> Setting bash plugin: brew, plugins dir doesn't exist: /tmp/123456654321"
}

@test "should install plugin" {
  local -r plugin='brew'
  run install_plugin "$plugin"

  assert_success
  assert_line --index 0 "INFO> Setting bash plugin: ${plugin}"
  assert_line --index 1 --regexp "'/tmp/.*/${plugin}.plugin.bash' -> '.*/dotfiles/dist/test/lib/fixtures/packages/${plugin}/content/${plugin}.plugin.bash'"

  [[ -L "${TMP_DIR}/${plugin}.plugin.bash" && -f "${TMP_DIR}/${plugin}.plugin.bash" ]]

  run grep "BASHC_PLUGINS=+($plugin)" "$BASH_GEN_SETTINGS_FILE"
  assert_output "BASHC_PLUGINS=+(brew)"
}

@test "should doesn't install package" {
  local pkg='pkg1'
  run install_package "$pkg"

  assert_failure
  assert_line --index 1 --regexp "ERROR> Setting package: ${pkg}, package doesn't exist: .*/dist/test/lib/fixtures/packages/${pkg}/content/${pkg}.plugin.bash"

  pkg='pkgfail'
  run install_package "$pkg"

  assert_failure
  assert_line --index 1 --regexp "pkgfail setup"
  assert_line --index 2 "ERROR> Setting package: ${pkg}"

}

@test 'should install package' {
  local -r pkg='brew'
  local -r plugin="$pkg"
  run install_package "$pkg"

  assert_success
  assert_line --index 1 --regexp "brew setup"
  assert_line --index 5 --regexp "INFO> DONE. Setting package: brew"

  [[ -L "${TMP_DIR}/${plugin}.plugin.bash" && -f "${TMP_DIR}/${plugin}.plugin.bash" ]]

  run grep "BASHC_PLUGINS=+($plugin)" "$BASH_GEN_SETTINGS_FILE"
}

