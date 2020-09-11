load test_helper


@test 'should install telegram' {
  dotf-i telegram
  [[ -x ~/.local/bin/Telegram ]]
  [[ -f ~/.local/share/applications/telegramdesktop.desktop ]]
  [[ -f ~/.local/share/icons/telegram.png ]]
}
