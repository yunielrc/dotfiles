load test_helper

@test 'should install & config portainer' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i portainer
  grep -q "http://${DAPP_PORTAINER_FQN}:${DAPP_PORTAINER_PORT}" \
          ~/.local/share/applications/portainer.desktop
  [[ -f ~/.local/share/icons/portainer.png ]]
  [[ -n "$(sudo docker ps --all --quiet --filter name=portainer)" ]]
}
