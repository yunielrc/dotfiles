load test_helper

@test 'should install 4kvideodownloader' {
  bash ../setup
  which 4kvideodownloader
}
