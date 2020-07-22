load test_helper

@test 'should install Popcorn-Time & config' {
  bash ../setup

  [[ -f /opt/Popcorn-Time/Popcorn-Time ]]
}
