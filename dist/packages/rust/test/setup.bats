load test_helper

@test 'should install rust & cargo' {
  dotf-i rust

  PATH="${PATH}:${HOME}/.cargo/bin"

  type -P cargo
  type -P rustc
}
