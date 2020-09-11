load test_helper

@test 'should install bash-git-prompt' {
  dotf-i bash-git-prompt
  [[ -f ~/.bash-git-prompt/gitprompt.sh ]]
}
