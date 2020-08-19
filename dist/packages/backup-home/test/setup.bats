load test_helper

@test 'should install backup-home' {

  set -o allexport
  . "$(realpath ../../../.env)"
  set +o allexport

  dotf-i backup-home
  [[ -f ~/.local/bin/backup-home ]]
  [[ -f ~/.backup-home.env ]]
  bash ../setup | grep -q 'backup-home currently installed'
}
