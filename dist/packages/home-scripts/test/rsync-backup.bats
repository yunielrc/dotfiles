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
  assert_output "mkdir: created directory '/tmp/Backup'
mkdir: created directory '/tmp/Backup/rsync-backup'
mkdir: created directory '/tmp/Backup/rsync-backup/tmp'
mkdir: created directory '/tmp/Backup/rsync-backup/tmp/user'
mkdir: created directory '/tmp/Backup/rsync-backup/tmp/user/files'
START backup, from '/tmp/user/files/Documents' to '/tmp/Backup/rsync-backup/tmp/user/files'
END backup done, from '/tmp/user/files/Documents' to '/tmp/Backup/rsync-backup/tmp/user/files'
ERROR> src directory does not exist: '/tmp/user/Videos'
ERROR> backup skipped, src: '/tmp/Backup/rsync-backup/tmp/user/files/Documents' is part of backup_dir: '/tmp/Backup/rsync-backup'
START backup, from '/tmp/user/files/Music' to '/tmp/Backup/rsync-backup/tmp/user/files'
END backup done, from '/tmp/user/files/Music' to '/tmp/Backup/rsync-backup/tmp/user/files'
rsync logs are saved in: /tmp/.rsync-backup.log"

  run diff <(cd /tmp/Backup/rsync-backup/tmp/user/ && find) <(cd /tmp/user/ && find )
  assert_output "1a2
> ./.rsync-backup.env"
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
  assert_output "mkdir: created directory '/tmp/user/files'
START restoring backup, from '/tmp/Backup/rsync-backup/tmp/user/files/Documents' to '/tmp/user/files'
END backup restored successfully, from '/tmp/Backup/rsync-backup/tmp/user/files/Documents' to '/tmp/user/files'
no backup for src: '/tmp/user/Videos'
no backup for src: '/tmp/Backup/rsync-backup/tmp/user/files/Documents'
START restoring backup, from '/tmp/Backup/rsync-backup/tmp/user/files/Music' to '/tmp/user/files'
END backup restored successfully, from '/tmp/Backup/rsync-backup/tmp/user/files/Music' to '/tmp/user/files'
rsync logs are saved in: /tmp/.rsync-backup.log"

  run diff <(cd /tmp/Backup/rsync-backup/tmp/user/ && find) <(cd /tmp/user/ && find )
  assert_output "1a2
> ./.rsync-backup.env"
}
