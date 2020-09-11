load test_helper

@test 'should install postman & config' {
  dotf-i postman

  [[ -x /opt/Postman/Postman ]]
  [[ -f /usr/share/applications/Postman.desktop ]]
}
