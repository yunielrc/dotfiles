#!/usr/bin/env bash

. "${LIBS}/bats-support/load.bash"
. "${LIBS}/bats-assert/load.bash"

export DEBUG=true

# shellcheck disable=SC2034
export LIBS_PATH="${DIST_PATH}/lib"
readonly LIBS_PATH
. "${DIST_PATH}/lib/utils.bash"

cd "$BATS_TEST_DIRNAME" || exit
