load test_helper

@test 'should install & configure bash-git-prompt' {
  dotf-i bash-git-prompt
  [[ -f ~/.bash-git-prompt/gitprompt.sh ]]
}
