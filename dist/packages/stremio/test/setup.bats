load test_helper

@test 'should install stremio' {
  dotf-i stremio
  type -P stremio
}
