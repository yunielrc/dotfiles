load test_helper

@test 'should install ruby & config' {
  bash ../setup
  type -P ruby
  type -P gem
}
