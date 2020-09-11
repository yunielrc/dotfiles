load test_helper2

setup() {
  export WORK_DIR="$(mktemp -d)"
  (
    cd "$WORK_DIR"
    # make fixture
    ## dest backup dir
    mkdir backup
    ## source backup data
    mkdir d1 d2 'd with spaces1' dexc1 'dexc2 with spaces1'
    touch d1/{f1,f2}
    touch d2/{f1,f2,f3}
    touch 'd with spaces1'/{f1,f2,f4,f5}
  )

cat <<EOF > "${WORK_DIR}/.backup-home.env"
MOUNT_SOURCE=
BACKUP_TARGET='${WORK_DIR}/backup'
EXCLUDE_FOLDERS='dexc1, dexc2 with spaces1'
EOF
}

teardown() {
  :
}

# @test 'should mount nfs device' {
#   [[ "$RUN_ON_DOCKER" == true ]] && skip
#   skip # TODO: setup nfs server for testing
#   . ../content/backup-home

#   run mount_nfs_device
# }

@test 'should make backup' {
  run bash ./backup-home --no-mount-nfs backup

  output="$(echo "$output" | sed -e '/^$/d' -e '/^sending/d' -e '/^sent/d' -e '/^total/d')"
  assert_success
  assert_output 'd with spaces1/
d with spaces1/f1
d with spaces1/f2
d with spaces1/f4
d with spaces1/f5
d1/
d1/f1
d1/f2
d2/
d2/f1
d2/f2
d2/f3'
}

@test 'should restore backup' {
  bash ./backup-home --no-mount-nfs backup
  rm -r "${WORK_DIR}"/{d1,d2,'d with spaces1',dexc1,'dexc2 with spaces1'}

  run bash ./backup-home restore --no-mount-nfs
  output="$(echo "$output" | sed -e '/^$/d' -e '/^sending/d' -e '/^sent/d' -e '/^total/d')"

  assert_success
  assert_output 'd with spaces1/
d with spaces1/f1
d with spaces1/f2
d with spaces1/f4
d with spaces1/f5
d1/
d1/f1
d1/f2
d2/
d2/f1
d2/f2
d2/f3'
}

@test 'invalid param' {
  run bash ./backup-home --no-mount-nfs invalid
  assert_failure 13
  assert_line --index 0 'Invalid param: invalid'
}

