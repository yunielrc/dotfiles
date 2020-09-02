load test_helper

setup() {
  . "${DIST_PATH}/.dotfilesrc"
  touch "$DOTF_BASH_GEN_SETTINGS_FILE"
}

@test "plugin doesn't exists" {
    run __install_plugin 'plugin1'

    assert_failure 10
    assert_line --index 1 --regexp "ERROR> Installing bash plugin: plugin1, plugin doesn't exist in: .*/dist/test/fixtures/packages/plugin1/content/plugin1.plugin.bash"
}

@test "plugin dir doesn't exists" {
    DOTF_BASH_PLUGINS_DIR="123456654321"
    run __install_plugin 'brew'

    assert_failure 11
    assert_output "INFO> Installing bash plugin: brew
ERROR> Installing bash plugin: brew, plugins dir doesn't exist: 123456654321"
}

@test 'plugin: error creating link' {
  chmod 0550 "${DOTF_BASH_PLUGINS_DIR}"

  run __install_plugin 'brew'

  assert_failure 12
  assert_line --index 2 'ERROR> Installing bash plugin: brew, creating link'
}

@test 'error adding plugin to settings' {
  chmod 0440 "${DOTF_BASH_GEN_SETTINGS_FILE}"

  run __install_plugin 'brew'

  assert_failure 13
  assert_line --index 3 'ERROR> Installing bash plugin: brew, adding plugin to settings'
}

@test "should install plugin" {
  local -r plugin='brew'

  run __install_plugin "$plugin"

  assert_success
  assert_line --index 2 --regexp "INFO> DONE. Installing bash plugin: brew"

  [[ -L "${DOTF_BASH_PLUGINS_DIR}/${plugin}.plugin.bash" && -f "${DOTF_BASH_PLUGINS_DIR}/${plugin}.plugin.bash" ]]

  run grep "BASHC_PLUGINS+=($plugin)" "$DOTF_BASH_GEN_SETTINGS_FILE"
  assert_output "BASHC_PLUGINS+=($plugin)"
}

@test "theme doesn't exists" {
    run __install_theme 'theme1'

    assert_failure 10
    assert_line --index 1 --regexp "ERROR> Installing bash theme: theme1, theme doesn't exist in: .*/dist/test/fixtures/packages/theme1/content/theme1.theme.bash"
}

@test "theme dir doesn't exists" {
    DOTF_BASH_THEMES_DIR="123456654321"
    run __install_theme 'brew'

    assert_failure 11
    assert_output "INFO> Installing bash theme: brew
ERROR> Installing bash theme: brew, themes dir doesn't exist: 123456654321"
}

@test 'theme: error creating link' {
  chmod 0550 "${DOTF_BASH_THEMES_DIR}"

  run __install_theme 'brew'

  assert_failure 12
  assert_line --index 2 'ERROR> Installing bash theme: brew, creating link'
}

@test "should install theme" {
  local -r theme='brew'

  run __install_theme "$theme"

  assert_success
  assert_line --index 2 --regexp "INFO> DONE. Installing bash theme: brew"

  [[ -L "${DOTF_BASH_THEMES_DIR}/${theme}.theme.bash" && -f "${DOTF_BASH_THEMES_DIR}/${theme}.theme.bash" ]]
}

@test "error package doesn't exist" {
  local pkg='pkg10'

  run __install_package "$pkg"

  assert_failure 10
  assert_output --regexp "ERROR> Installing package: pkg10, package doesn't exist: .*/dist/test/fixtures/packages/pkg10"

  pkg='pkgfail'
  run __install_package "$pkg"

  assert_failure 11
  assert_output "pkgfail setup
ERROR> Installing package: pkgfail, executing package setup"
}

@test 'should no install package, plugin fail' {
  local -r pkg='brew'
  local -r plugin="$pkg"
  chmod 0440 "${DOTF_BASH_GEN_SETTINGS_FILE}"

  run __install_package "$pkg"

  assert_failure 12
  assert_line --index 5 'ERROR> Installing package: brew, installing bash plugin'
}

@test 'should install package' {
  local -r pkg='brew'
  local -r plugin="$pkg"
  run __install_package "$pkg"

  assert_success
  assert_line --index 0 --regexp "brew setup"
  assert_line --index 3 --regexp "INFO> DONE. Installing bash plugin: brew"

  [[ -L "${DOTF_BASH_PLUGINS_DIR}/${plugin}.plugin.bash" && -f "${DOTF_BASH_PLUGINS_DIR}/${plugin}.plugin.bash" ]]

  run grep "BASHC_PLUGINS+=($plugin)" "$DOTF_BASH_GEN_SETTINGS_FILE"
  assert_output "BASHC_PLUGINS+=($plugin)"
}
