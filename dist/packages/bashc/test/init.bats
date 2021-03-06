load test_helper

@test "BASHC_FILES empty" {
  local -r BASHC_FILES=()

  run bashc::__load_files

  assert_success
  assert_output "DEBUG> BASHC_FILES empty"
}

@test "should not load files" {
  local -r BASHC_FILES=(environment file1)

  run bashc::__load_files

  assert_success
  assert_output --regexp "environment
DEBUG> file loaded '.*/dist/packages/bashc/test/fixtures/.bashc/environment'
DEBUG> don't exists: 'file1' in '.*/dist/packages/bashc/test/fixtures/.bashc'"
}

@test "should load files" {
  local -r BASHC_FILES=(environment aliases)

  run bashc::__load_files

  assert_success
  assert_output --regexp "environment
DEBUG> file loaded '.*/dist/packages/bashc/test/fixtures/.bashc/environment'
aliases
DEBUG> file loaded '.*/dist/packages/bashc/test/fixtures/.bashc/aliases'"
}

@test "BASHC_THEME empty" {
    local -r BASHC_THEME=''

    run bashc::__load_theme
    # becho "${status}:${output}"
    assert_success
    assert_output "DEBUG> theme arg empty"
}

@test "should load theme" {
    local BASHC_THEME='example1'

    run bashc::__load_theme

    assert_success
    assert_output --regexp "user example1 theme
DEBUG> theme loaded 'example1' from '.*/dist/packages/bashc/test/fixtures/.bashc/themes/user/example1.theme.bash'"
}

@test "should not load theme" {
    local -r BASHC_THEME='example123'

    run bashc::__load_theme
    # becho "${status}:${output}"
    assert_failure
    assert_output --regexp "ERROR> theme doesn't exist: 'example123' in '.*/dist/packages/bashc/test/fixtures/.bashc/\{local 3rd user\}'"
}

@test "BASHC_PLUGINS empty" {
    local -r BASHC_PLUGINS=()

    run bashc::__load_plugins
    # becho "${status}:${output}"
    assert_success
    assert_output "DEBUG> BASHC_PLUGINS empty"

}
@test "should not load plugins" {
    local -r BASHC_PLUGINS=(example0 plugin1)

    run bashc::__load_plugins
    # becho "${status}:${output}"
    assert_failure
    assert_output --regexp "3rd example0 plugin
DEBUG> plugin loaded '.*/dist/packages/bashc/test/fixtures/.bashc/plugins/3rd/example0.plugin.bash'
user example0 plugin
DEBUG> plugin loaded '.*/dist/packages/bashc/test/fixtures/.bashc/plugins/user/example0.plugin.bash'
ERROR> plugin doesn't exist: 'plugin1' folders '.*/dist/packages/bashc/test/fixtures/.bashc/\{local 3rd user\}"
}

@test "should load plugins" {
    local -r BASHC_PLUGINS=(example0 example1)

    run bashc::__load_plugins

    assert_success
    assert_output --regexp "3rd example0 plugin
DEBUG> plugin loaded '.*/dist/packages/bashc/test/fixtures/.bashc/plugins/3rd/example0.plugin.bash'
user example0 plugin
DEBUG> plugin loaded '.*/dist/packages/bashc/test/fixtures/.bashc/plugins/user/example0.plugin.bash'
user example1 plugin
DEBUG> plugin loaded '.*/dist/packages/bashc/test/fixtures/.bashc/plugins/user/example1.plugin.bash'"

}

@test "should ok main" {
    local -r BASHC_FILES=(environment)
    local -r BASHC_THEME='example0'
    local -r BASHC_PLUGINS=(example0)

    run bashc::main

    assert_success
    assert_output --regexp "environment
DEBUG> file loaded '.*/dist/packages/bashc/test/fixtures/.bashc/environment'
user example0 theme
DEBUG> theme loaded 'example0' from '.*/dist/packages/bashc/test/fixtures/.bashc/themes/user/example0.theme.bash'
3rd example0 plugin
DEBUG> plugin loaded '.*/dist/packages/bashc/test/fixtures/.bashc/plugins/3rd/example0.plugin.bash'
user example0 plugin
DEBUG> plugin loaded '.*/dist/packages/bashc/test/fixtures/.bashc/plugins/user/example0.plugin.bash'"
}
