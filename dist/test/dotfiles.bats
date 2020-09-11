load test_helper

setup() {
  export INCLUDE_BASE_CM=false
}

@test 'error, configuration management does not exists' {
  run bash "${DIST_PATH}/dotfiles" config1

  assert_failure 1
  assert_line --index 0 --regexp "ERROR> Configuration management 'config1' doesn't exists"
}

@test 'should run configuration' {
  run bash "${DIST_PATH}/dotfiles" desktop

  assert_success
  assert_line --index 1 "> Installing package pkgfail"
  assert_line --index 2 "pkgfail setup"
  assert_line --index 3 "ERROR> Installing package: pkgfail, executing package setup"
  assert_line --index 4 "> FAIL. Installing package pkgfail"
  assert_line --index 5 "> Installing package brew1"
  assert_line --index 6 "brew1 setup"
  assert_line --index 7 "INFO> Installing bash plugin: brew1"
  assert_line --index 8 --regexp "'/tmp/.*/brew1.plugin.bash' -> '.*/dist/test/fixtures/packages/brew1/content/brew1.plugin.bash'"
  assert_line --index 9 --regexp "INFO> DONE. Installing bash plugin: brew1"
  assert_line --index 10 --regexp "INFO> Installing bash theme: brew1"
  assert_line --index 12 --regexp "INFO> DONE. Installing bash theme: brew1 "
  assert_line --index 13 --regexp "> DONE. Installing package brew1"
}


@test 'should load base cm: base1 and base2' {
  export INCLUDE_BASE_CM=true
  run sed -e '/Setting cm/d' -e '/^$/d' <(bash "${DIST_PATH}/dotfiles" dummy)
  assert_success
  assert_output 'base1 cm
base2 cm
dummy cm'
}


