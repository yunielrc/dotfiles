load test_helper

@test 'should install stremio & config' {
  bash ../setup
  which stremio
}
