load test_helper

@test 'should install Popcorn-Time' {
  dotf-i popcorn-time
  [[ -x /opt/Popcorn-Time/Popcorn-Time ]]
}
