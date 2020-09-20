load test_helper_gpg

setup_file() {
  gpg --batch --yes --passphrase '' --quick-gen-key gpgid default default 0
  [[ ! -d ~/.gnupg ]] && mkdir ~/.gnupg
  cat <<EOF >> ~/.gnupg/gpg.conf
use-agent
pinentry-mode loopback
EOF
  echo 'allow-loopback-pinentry' > ~/.gnupg/gpg-agent.conf
}

@test 'main: show usage' {
  run "${REL_BIN}/gpg-backup"
  assert_success
  assert_line --index 1 'gpg-backup [OPTIONS] COMMAND'

  run "${REL_BIN}/gpg-backup" --help
  assert_success
  assert_line --index 1 'gpg-backup [OPTIONS] COMMAND'
}

@test 'main: show invalid paramter' {
  run "${REL_BIN}/gpg-backup" p
  assert_failure 10
  assert_line --index 0 'Invalid parameter: p'
}

@test 'backup_parse_args: should show usage_backup' {
  run "${REL_BIN}/gpg-backup" backup -h
  assert_success
  assert_line --index 1 'gpg-backup backup [OPTIONS] [backup_file]'
}

@test 'backup_parse_args: recipient parameter unset' {
  run "${REL_BIN}/gpg-backup" backup -r
  assert_failure
  assert_line --index 2 'gpg-backup [OPTIONS] COMMAND'
}

# @test 'backup_parse_args: should parse args' {
#   . ../home/.usr/bin/gpg-backup
#   mock function
#   backup() {
#     echo "$1"
#     echo "$2"
#   }
#   run backup_parse_args backup -r user1 mybackup.gpg

#   assert_success
#   # assert_line --index 0 'gpg-backup [OPTIONS] COMMAND'
# }

@test 'backup_parse_args: should parse args' {\
  # mock function
  backup() {
    echo "$1"
    echo "$2"
  }
  export -f backup

  run "${REL_BIN}/gpg-backup" backup -r user mybackup.gpg

  assert_success
  assert_output 'user
mybackup.gpg'
}

@test 'backup_parse_args: error, GPG_RECIPIENT unset' {
  # mock function
  backup() {
    echo "$1"
    echo "$2"
  }
  export -f backup

  run "${REL_BIN}/gpg-backup" backup mybackup.gpg

  assert_failure
  assert_line --index 0 --partial 'GPG_RECIPIENT: unbound variable'
}

@test 'backup_parse_args: should parse args, and load GPG_RECIPIENT' {
  # mock function
  backup() {
    echo "$1"
    echo "$2"
  }
  export -f backup

  export ETC_DIR="$(realpath ./fixtures/gpg-backup/)"
  run "${REL_BIN}/gpg-backup" backup

  assert_success
  assert_line --index 0 gpgid
  assert_line --index 1 --regexp '^gpg-backup-.+.gpg$'
}

@test 'backup: should create a backup' {
  export WORK_DIR="$(mktemp -d)"
  run "${REL_BIN}/gpg-backup" backup -r gpgid mybackup.gpg
  assert_success
  assert_output ''

  file "${WORK_DIR}/mybackup.gpg" | grep -q 'GPG symmetrically encrypted data'

  run gpgtar --list-archive --gpg-args "--batch --passphrase ${TEST_PASSPHRASE}" "${WORK_DIR}/mybackup.gpg"

  assert_line --index 3 --partial ./ownertrust
  assert_line --index 4 --partial ./private_key.asc
  assert_line --index 5 --partial ./public_key.asc
}

@test 'restore_parse_args: should show usage_restore' {
  run "${REL_BIN}/gpg-backup" restore -h
  assert_success
  assert_line --index 1 'gpg-backup restore [OPTIONS] [backup_file]'
}

@test 'restore_parse_args: should parse args' {\
  # mock function
  restore() {
    echo "$1"
  }
  export -f restore

  run "${REL_BIN}/gpg-backup" restore mybackup.gpg

  assert_success
  assert_output mybackup.gpg
}

@test 'restore_parse_args: error, backup_file unset' {
  # mock function
  restore() {
    echo "$1"
  }
  export -f restore

  run "${REL_BIN}/gpg-backup" restore

  assert_failure
  assert_line --index 0 --partial 'backup_file: unbound variable'
}

@test 'backup: should restore a backup' {
  export WORK_DIR="$(mktemp -d)"
  "${REL_BIN}/gpg-backup" backup -r gpgid mybackup.gpg

  run "${REL_BIN}/gpg-backup" restore mybackup.gpg
  assert_success
  assert_output --regexp 'gpgtar: gpg: AES256 encrypted data
gpgtar: gpg: encrypted with 1 passphrase
gpg: key (\d|\w)+: "gpgid" not changed
gpg: Total number processed: 1
gpg:              unchanged: 1
gpg: key (\d|\w)+: "gpgid" not changed
gpg: key (\d|\w)+: secret key imported
gpg: Total number processed: 1
gpg:              unchanged: 1
gpg:       secret keys read: 1
gpg:  secret keys unchanged: 1'
}
