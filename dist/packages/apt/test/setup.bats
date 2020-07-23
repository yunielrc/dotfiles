load test_helper

teardown() {
  [[ -f /etc/apt/apt.conf.d/00proxy ]] && sudo rm /etc/apt/apt.conf.d/00proxy
}

@test 'should config apt' {
  env APT_PROXY_URL='http://192.168.1.10:8080/' bash ../setup

  grep -P 'Acquire::http::Proxy\s+"http://192\.168\.1\.10:8080/";' /etc/apt/apt.conf.d/00proxy
}
