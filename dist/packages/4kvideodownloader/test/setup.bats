load test_helper

@test 'should install 4kvideodownloader' {
  dotf-i 4kvideodownloader
  type -P 4kvideodownloader
}
