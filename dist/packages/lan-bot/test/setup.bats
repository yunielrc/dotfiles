load test_helper

@test 'should install lan-bot & config' {
  dotf-i lan-bot
  type -P airos-random-mac-name
  type -P airos-random-mac-name-log
  [[ -f ~/.local/share/applications/airos-random-mac-name.desktop ]]
  [[ -f ~/.local/share/icons/airos-random-mac-name.png ]]
}
