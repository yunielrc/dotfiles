load test_helper

teardown() {
  [[ -d ~/.local/share/applications/lanapps ]] && rm -r ~/.local/share/applications/lanapps
}

@test 'should install lanapps' {
  dotf-i lanapps
  [[ -d ~/.local/share/applications/lanapps ]]
}
