load test_helper

@test 'should install 4kvideodownloader & config' {
  bash ../setup
  which 4kvideodownloader
}
