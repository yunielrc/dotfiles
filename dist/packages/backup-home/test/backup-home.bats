load test_helper

setup() {
  :
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
  readonly TMP_DIR="$(mktemp -d)"
  (
    cd "$TMP_DIR"
    # make fixture
    ## dest backup dir
    mkdir backup
    ## source backup data
    mkdir d1 d2 'd with spaces1' dexc1 'dexc2 with spaces1'
    touch d1/{f1,f2}
    touch d2/{f1,f2,f3}
    touch 'd with spaces1'/{f1,f2,f4,f5}
  )
  WORK_DIR="$TMP_DIR"
  . ../content/backup-home

  run make_home_backup "${TMP_DIR}/backup" 'dexc1, dexc2 with spaces1'

  output="$(echo "$output" | sed -e '/^$/d' -e '/^sending/d' -e '/^sent/d' -e '/^total/d')"
  assert_output 'd1/
d1/f1
d1/f2
d2/
d2/f1
d2/f2
d2/f3
d with spaces1/
d with spaces1/f1
d with spaces1/f2
d with spaces1/f4
d with spaces1/f5'
}

