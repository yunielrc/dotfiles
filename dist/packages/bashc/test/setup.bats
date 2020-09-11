load test_helper

setup() {
  [[ -d ~/.bashc ]] && rm -r ~/.bashc
  [[ -f ~/.bashrc ]] && rm ~/.bashrc
}

@test 'should install bashc' {
  dotf-i bashc
  [[ -d ~/.bashc ]]
  grep --quiet '~/.bashc/init' ~/.bashrc
}
