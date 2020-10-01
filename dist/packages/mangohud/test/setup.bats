load test_helper

@test 'should install mangohud' {
  dotf-i mangohud
  type -P mangohud
  [[ -r ~/.config/MangoHud/MangoHud.conf ]]
}
