load test_helper

@test 'should install rust & cargo' {
  bash ../setup

  PATH="${PATH}:${HOME}/.cargo/bin"

  type -P cargo
  type -P rustc
}
