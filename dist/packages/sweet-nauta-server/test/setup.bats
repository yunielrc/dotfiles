load test_helper

setup_file() {
  if [[ -f ~/.npmrc ]]; then
    rm ~/.npmrc
  fi
  if [[ -f /root/.npmrc ]]; then
    sudo rm /root/.npmrc
  fi
}

@test 'should install sweet-nauta-server' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i sweet-nauta-server
  [[ -f /opt/sweet-nauta-server/bin/login ]]
}
