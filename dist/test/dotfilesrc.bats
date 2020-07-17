load test_helper

setup() {
  . "${DIST_PATH}/.dotfilesrc"
  touch "$BASH_GEN_SETTINGS_FILE"
}

@test "plugin doesn't exists" {
    run __install_plugin 'plugin1'

    assert_failure 10
    assert_line --index 1 --regexp "ERROR> Installing bash plugin: plugin1, plugin doesn't exist in: .*/dist/test/fixtures/packages/plugin1/content/plugin1.plugin.bash"
}

@test "plugin dir doesn't exists" {
    BASH_PLUGINS_DIR="123456654321"
    run __install_plugin 'brew'

    assert_failure 11
    assert_output "INFO> Installing bash plugin: brew
ERROR> Installing bash plugin: brew, plugins dir doesn't exist: 123456654321"
}

@test 'error creating link' {
  chmod 0550 "${BASH_PLUGINS_DIR}"

  run __install_plugin 'brew'

  assert_failure 12
  assert_line --index 2 'ERROR> Installing bash plugin: brew, creating link'
}

@test 'error adding plugin to settings' {
  chmod 0440 "${BASH_GEN_SETTINGS_FILE}"

  run __install_plugin 'brew'

  assert_failure 13
  assert_line --index 3 'ERROR> Installing bash plugin: brew, adding plugin to settings'
}

@test "should install plugin" {
  local -r plugin='brew'

  run __install_plugin "$plugin"

  assert_success
  assert_line --index 2 --regexp "INFO> DONE. Installing bash plugin: brew"

  [[ -L "${BASH_PLUGINS_DIR}/${plugin}.plugin.bash" && -f "${BASH_PLUGINS_DIR}/${plugin}.plugin.bash" ]]

  run grep "BASHC_PLUGINS+=($plugin)" "$BASH_GEN_SETTINGS_FILE"
  assert_output "BASHC_PLUGINS+=($plugin)"
}

@test "error package doesn't exist" {
  local pkg='pkg1'

  run __install_package "$pkg"

  assert_failure 10
  assert_output --regexp "ERROR> Installing package: pkg1, package doesn't exist: .*/dist/test/fixtures/packages/pkg1/setup"

  pkg='pkgfail'
  run __install_package "$pkg"

  assert_failure 11
  assert_output "pkgfail setup
ERROR> Installing package: pkgfail, executing package setup"
}

@test 'should no install package, plugin fail' {
  local -r pkg='brew'
  local -r plugin="$pkg"
  chmod 0440 "${BASH_GEN_SETTINGS_FILE}"

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

  [[ -L "${BASH_PLUGINS_DIR}/${plugin}.plugin.bash" && -f "${BASH_PLUGINS_DIR}/${plugin}.plugin.bash" ]]

  run grep "BASHC_PLUGINS+=($plugin)" "$BASH_GEN_SETTINGS_FILE"
  assert_output "BASHC_PLUGINS+=($plugin)"
}

@test 'should create desktop file' {

  local app_dir='/home/user/.local/share/applications'
  local -r file_name='coronavirus-app-webapp'
  local desktop_path="${app_dir}/${file_name}.desktop"

  run create_desktop_file 'Coronavirus App' \
    'Track the spread of the Coronavirus Covid-19 outbreak' \
    'Maps;Education' \
    "mapa;coronavirus;covid" \
    "https://coronavirus.app" \
    "coronavirus-app" \
    'coronavirus.app' \
    "${file_name}" \
    "${app_dir}"

  assert_output "Created desktop file: ${desktop_path}"

  run bash -c "ls -l $desktop_path | cut -d' ' -f3,4"
  assert_output 'user user'

  run grep --only-matching \
           --regexp '\[Desktop Entry\]' \
           --regexp 'Name=Coronavirus App' \
           --regexp 'StartupWMClass=coronavirus.app' \
           "$desktop_path"

  assert_output "[Desktop Entry]
Name=Coronavirus App
StartupWMClass=coronavirus.app"

  # app_dir='/usr/share/applications'
  # desktop_path="${app_dir}/${file_name}.desktop"

  # run create_desktop_file 'Coronavirus App' \
  #   'Track the spread of the Coronavirus Covid-19 outbreak' \
  #   'Maps;Education' \
  #   "mapa;coronavirus;covid" \
  #   "https://coronavirus.app" \
  #   "coronavirus-app" \
  #   'coronavirus.app' \
  #   "${file_name}" \
  #   "${app_dir}"

  # assert_line --index 2 "Created desktop file: ${desktop_path}"

  # run bash -c "ls -l $desktop_path | cut -d' ' -f3,4"
  # assert_output 'root root'
}
