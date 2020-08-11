load test_helper

@test 'should install vagrant' {
  bash ../setup
  type -P vagrant
  bash ../setup | grep -q 'vagrant currently installed'
}
