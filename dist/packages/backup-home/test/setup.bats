load test_helper

@test 'should install backup-home' {

  set -o allexport
  . "$(realpath ../../../.env)"
  set +o allexport

  PKG_CONTENT="$(realpath ../content)" bash ../setup
  [[ -f ~/.local/bin/backup-home ]]
  [[ -f ~/.backup-home.env ]]
  PKG_CONTENT="$(realpath ../content)" bash ../setup | grep -q 'backup-home currently installed'
}
