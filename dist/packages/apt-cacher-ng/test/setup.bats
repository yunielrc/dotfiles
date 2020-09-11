load test_helper

teardown() {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && return 0;
  [[ -f /etc/apt/apt.conf.d/00proxy ]] && sudo rm /etc/apt/apt.conf.d/00proxy
}

@test 'should install & config apt-cacher-ng' {
  [[ "${RUN_ON_DOCKER:-}" == true ]] && skip
  dotf-i apt-cacher-ng
  grep -P "Proxy: ${PROXY_URL}" /etc/apt-cacher-ng/acng.conf
  readonly APT_PROXY_URL='http://localhost:3142'
  grep -P "Acquire::http::Proxy \"${APT_PROXY_URL}\";" /etc/apt/apt.conf.d/00proxy
}
