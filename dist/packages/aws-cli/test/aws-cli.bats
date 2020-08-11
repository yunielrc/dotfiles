load test_helper


@test 'should install aws-cli-linux' {
  bash ../setup
  type -P aws
  bash ../setup | grep -q 'aws-cli currently installed'
}
