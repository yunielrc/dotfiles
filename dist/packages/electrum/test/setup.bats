load test_helper

@test 'should install electrum' {
  dotf-i electrum
  [[ -x ~/.local/bin/Electrum.AppImage ]]
  [[ -f ~/.local/share/applications/Electrum.desktop ]]
  [[ -f ~/.local/share/icons/electrum.png ]]
}
