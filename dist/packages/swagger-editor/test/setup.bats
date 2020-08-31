load test_helper

@test 'should install & config swagger-editor' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i root-config
  dotf-i swagger-editor
  grep -q "http://${DAPP_SWAGGER_EDITOR_FQN}:${DAPP_SWAGGER_EDITOR_PORT}" \
          ~/.local/share/applications/swagger-editor.desktop
  [[ -f ~/.local/share/icons/swagger-editor.png ]]
  [[ -n "$(sudo docker ps --all --quiet --filter name=swagger-editor)" ]]
}
