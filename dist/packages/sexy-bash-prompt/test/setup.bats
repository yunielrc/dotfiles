load test_helper

@test 'should install & configure sexy-bash-prompt' {
  dotf-i sexy-bash-prompt
  [[ -f ~/.bash_prompt ]]
}
