#!/usr/bin/env bash

# shellcheck disable=SC1090
. "${LIBS}/bats-support/load.bash"
. "${LIBS}/bats-assert/load.bash"

export DEBUG=true
# shellcheck disable=SC1090
. "${DIST_PATH}/lib/utils.bash"

cd "$BATS_TEST_DIRNAME" || exit
