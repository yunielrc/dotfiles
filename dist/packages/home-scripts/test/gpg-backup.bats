load test_helper

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
  assert_line --index 1 'gpg-backup backup [OPTIONS] [backup_name]'
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

  export PREFIX_DIR="$(realpath ./fixtures/gpg-backup/)"
  run "${REL_BIN}/gpg-backup" backup

  assert_success
  assert_line --index 0 gpgid
  assert_line --index 1 --regexp '^gpg-backup-.+.gpg$'
}

@test 'backup_parse_args: should create a backup' {
  # mock function
  gpgtar_symmetric_encrypt() {
    local -r output="$1"
    local -r from_directory="$2"
    echo "$output"
    echo "$from_directory"
    touch "$output"
  }
  export -f gpgtar_symmetric_encrypt
  export WORK_DIR="$BATS_TMPDIR"
  run "${REL_BIN}/gpg-backup" backup -r gpgid mybackup.gpg

  assert_success
  assert_output 'gpg-backup.gpg
./gpg-backup'
  [[ -f "${WORK_DIR}/mybackup.gpg" ]]
}

