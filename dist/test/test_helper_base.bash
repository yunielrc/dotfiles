#!/usr/bin/env bash

. "${LIBS_DIR}/bats-support/load.bash"
. "${LIBS_DIR}/bats-assert/load.bash"

export DEBUG=true
export PATH="${PATH}:~/.local/bin"

cd "$BATS_TEST_DIRNAME" || exit
