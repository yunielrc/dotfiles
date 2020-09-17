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
4 directories to backup
START backup 1/4 from '/tmp/user/files/Documents'
mkdir: created directory '/tmp/Backup/rsync-backup/tmp'
mkdir: created directory '/tmp/Backup/rsync-backup/tmp/user'
mkdir: created directory '/tmp/Backup/rsync-backup/tmp/user/files'
OK backup 1/4 from '/tmp/user/files/Documents' to '/tmp/Backup/rsync-backup/tmp/user/files'
START backup 2/4 from '/tmp/user/Videos'
ERROR backup 2/4, src directory does not exist: '/tmp/user/Videos'
START backup 3/4 from '/tmp/Backup/rsync-backup/tmp/user/files/Documents'
ERROR backup 3/4, src: '/tmp/Backup/rsync-backup/tmp/user/files/Documents' is part of backup_dir
START backup 4/4 from '/tmp/user/files/Music'
OK backup 4/4 from '/tmp/user/files/Music' to '/tmp/Backup/rsync-backup/tmp/user/files'
2/4 backups ok, 2 failed
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
  assert_output "4 backups to restore
START restore 1/4 from '/tmp/Backup/rsync-backup/tmp/user/files/Documents'
mkdir: created directory '/tmp/user/files'
OK restore 1/4 from '/tmp/Backup/rsync-backup/tmp/user/files/Documents' to '/tmp/user/files'
START restore 2/4 from '/tmp/Backup/rsync-backup/tmp/user/Videos'
ERROR restore 2/4, no backup for src: '/tmp/user/Videos'
START restore 3/4 from '/tmp/Backup/rsync-backup/tmp/Backup/rsync-backup/tmp/user/files/Documents'
ERROR restore 3/4, no backup for src: '/tmp/Backup/rsync-backup/tmp/user/files/Documents'
START restore 4/4 from '/tmp/Backup/rsync-backup/tmp/user/files/Music'
OK restore 4/4 from '/tmp/Backup/rsync-backup/tmp/user/files/Music' to '/tmp/user/files'
2/4 restores ok, 2 failed
rsync logs are saved in: /tmp/.rsync-backup.log"

  run diff <(cd /tmp/Backup/rsync-backup/tmp/user/ && find) <(cd /tmp/user/ && find )
  assert_output "1a2
> ./.rsync-backup.env"
}
