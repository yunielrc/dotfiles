#!/usr/bin/env bash

. "${LIBS}/bats-support/load.bash"
. "${LIBS}/bats-assert/load.bash"

export DEBUG=true
export PATH="${PATH}:~/.local/bin"

cd "$BATS_TEST_DIRNAME" || exit
