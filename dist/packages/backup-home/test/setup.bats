load test_helper

@test 'should install backup-home' {
  dotf-i backup-home
  [[ -f "${HOME_BIN}/backup-home" ]]
  [[ -f ~/.backup-home.env ]]
}
