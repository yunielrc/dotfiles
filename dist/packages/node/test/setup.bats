load test_helper

teardown_file() {
  if [[ -f ~/.npmrc ]]; then
    rm ~/.npmrc
  fi
  if [[ -f /root/.npmrc ]]; then
    sudo rm /root/.npmrc
  fi
}

@test 'should install node' {
  dotf-i node
  type -P node
  type -P yarn
}
