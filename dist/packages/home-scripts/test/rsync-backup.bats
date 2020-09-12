load test_helper_rsync

setup_file() {
  # for directory shortening
  cp -r ./fixtures/rsync-backup/root/home/user "$BATS_TMPDIR"
  # chmod -R 500 "${BATS_TMPDIR}/user"
}

@test 'main: show usage' {
  run "${REL_BIN}/rsync-backup"
  assert_success
  assert_line --index 1 'rsync-backup [OPTIONS] COMMAND'

  run "${REL_BIN}/rsync-backup" --help
  assert_success
  assert_line --index 1 'rsync-backup [OPTIONS] COMMAND'

  run "${REL_BIN}/rsync-backup" -h
  assert_success
  assert_line --index 1 'rsync-backup [OPTIONS] COMMAND'
}

@test 'main: show invalid parameter' {
  run "${REL_BIN}/rsync-backup" p
  assert_failure 10
  assert_line --index 0 --partial 'Invalid parameter: p'
}

@test 'backup: No command' {
  run "${REL_BIN}/rsync-backup" -n
  assert_failure 11
  assert_line --index 0 --partial 'No command'
}

@test 'backup: should make a backup' {
  run "${REL_BIN}/rsync-backup" -n backup
  assert_success
  assert_output --regexp "mkdir: created directory '/.*/Backup'
mkdir: created directory '/.*/Backup/rsync-backup'
mkdir: created directory '/.*/Backup/rsync-backup/.*'
mkdir: created directory '/.*/Backup/rsync-backup/.*/user'
mkdir: created directory '/.*/Backup/rsync-backup/.*/user/files'
sending incremental file list
Documents/
Documents/doc1
Documents/doc2
Documents/my docs/
Documents/my docs/mydocs

.*
.*
ERROR>.*: src directory does not exist: '/.*/user/Videos'
ERROR>.*: backup skipped, src: '/.*/Backup/rsync-backup/.*/user/files/Documents' is part of backup_dir: '/.*/Backup/rsync-backup'
sending incremental file list
Music/
Music/foo.mp3
Music/my collection/
Music/my collection/m1.mp3
Music/my collection/m2.mp3"
}

@test 'restore: backup_dir directory does not exist' {
  export RSYNC_BACKUP_BACKUP_FOLDER='invalid_name'
  run "${REL_BIN}/rsync-backup" -n restore
  assert_failure 1
  assert_line --index 0 --regexp ".*backup_dir directory does not exist: '/.*/invalid_name'"
}

@test 'restore: should restore a backup' {
  run "${REL_BIN}/rsync-backup" -n backup
  assert_success

  rm -rf "${BATS_TMPDIR}/user/files"
  run "${REL_BIN}/rsync-backup" -n restore
  assert_success
  assert_output --regexp "mkdir: created directory '/.*/user/files'
sending incremental file list
Documents/
Documents/doc1
Documents/doc2
Documents/my docs/
Documents/my docs/mydocs

.*
.*
no backup for src: '/.*/user/Videos'
no backup for src: '/.*/Backup/rsync-backup/.*/user/files/Documents'
sending incremental file list
Music/
Music/foo.mp3
Music/my collection/
Music/my collection/m1.mp3
Music/my collection/m2.mp3"
}
