load test_helper


@test 'should install staruml & config' {
  dotf-i staruml
  [[ -x ~/.local/bin/StarUML-x86_64.AppImage ]]
  [[ -f ~/.local/share/applications/StarUML.desktop ]]
  [[ -f ~/.local/share/icons/staruml.png ]]
}
