load test_helper

setup() {
  [[ -d ~/.bashc ]] && rm -r ~/.bashc
  [[ -f ~/.bashrc ]] && rm ~/.bashrc
}

@test 'should install bashc' {
  run dotf-i bashc
  [[ -d ~/.bashc ]]
  grep --silent '~/.bashc/init' ~/.bashrc
}
