load test_helper

setup() {
  TMP_DIR="$(mktemp -d)"
  DIST_PATH="$(realpath ./fixtures)"
  PKG_PATH="${DIST_PATH}/packages"

  BASH_PLUGINS_DIR="${TMP_DIR}/plugins"
  mkdir -p "$BASH_PLUGINS_DIR"
  BASH_GEN_SETTINGS_FILE="${TMP_DIR}/settings_gen.bash"
  touch "${BASH_GEN_SETTINGS_FILE}"
}

@test "plugin doesn't exists" {
    run install_plugin 'plugin1'

    assert_failure 10
    assert_line --index 1 --regexp "ERROR> Installing bash plugin: plugin1, plugin doesn't exist in: .*/dist/test/lib/fixtures/packages/plugin1/content/plugin1.plugin.bash"
}

@test "plugin dir doesn't exists" {
    BASH_PLUGINS_DIR="123456654321"
    run install_plugin 'brew'

    assert_failure 11
    assert_output "INFO> Installing bash plugin: brew
ERROR> Installing bash plugin: brew, plugins dir doesn't exist: 123456654321"
}

@test 'error creating link' {
  chmod 0550 "${BASH_PLUGINS_DIR}"

  run install_plugin 'brew'

  assert_failure 12
  assert_line --index 2 'ERROR> Installing bash plugin: brew, creating link'
}

@test 'error adding plugin to settings' {
  chmod 0440 "${BASH_GEN_SETTINGS_FILE}"

  run install_plugin 'brew'

  assert_failure 13
  assert_line --index 3 'ERROR> Installing bash plugin: brew, adding plugin to settings'
}

@test "should install plugin" {
  local -r plugin='brew'

  run install_plugin "$plugin"

  assert_success
  assert_line --index 2 "INFO> DONE. Installing bash plugin: brew "

  [[ -L "${BASH_PLUGINS_DIR}/${plugin}.plugin.bash" && -f "${BASH_PLUGINS_DIR}/${plugin}.plugin.bash" ]]

  run grep "BASHC_PLUGINS=+($plugin)" "$BASH_GEN_SETTINGS_FILE"
  assert_output "BASHC_PLUGINS=+($plugin)"
}

@test "error package doesn't exist" {
  local pkg='pkg1'

  run install_package "$pkg"

  assert_failure 10
  assert_line --index 1 --regexp "ERROR> Installing package: pkg1, package doesn't exist: .*/dist/test/lib/fixtures/packages/pkg1/content/pkg1.plugin.bash"

  pkg='pkgfail'
  run install_package "$pkg"

  assert_failure 11
  assert_line --index 1 --regexp "pkgfail setup"
  assert_line --index 2 "ERROR> Installing package: pkgfail, executing package setup"
}

@test 'should no install package, plugin fail' {
  local -r pkg='brew'
  local -r plugin="$pkg"
  chmod 0440 "${BASH_GEN_SETTINGS_FILE}"

  run install_package "$pkg"

  assert_failure 12
  assert_line --index 6 'ERROR> Installing package: brew, installing bash plugin'
}

@test 'should install package' {
  local -r pkg='brew'
  local -r plugin="$pkg"
  run install_package "$pkg"

  assert_success
  assert_line --index 1 --regexp "brew setup"
  assert_line --index 5 --regexp "INFO> DONE. Installing package: brew"

  [[ -L "${BASH_PLUGINS_DIR}/${plugin}.plugin.bash" && -f "${BASH_PLUGINS_DIR}/${plugin}.plugin.bash" ]]

  run grep "BASHC_PLUGINS=+($plugin)" "$BASH_GEN_SETTINGS_FILE"
  assert_output "BASHC_PLUGINS=+($plugin)"
}

