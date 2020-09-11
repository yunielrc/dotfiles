load test_helper

teardown() {
  [[ -d ~/.local/share/applications/webapps ]] && rm -r ~/.local/share/applications/webapps
}

@test 'should install webapps' {
  dotf-i webapps
  [[ -d ~/.local/share/applications/webapps ]]
}
