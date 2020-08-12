load test_helper

@test 'should install sweet-nauta-server' {
  bash ../setup
  [[ -f /opt/sweet-nauta-server/bin/login ]]
  bash ../setup | grep -q 'sweet-nauta-server currently installed'
}
