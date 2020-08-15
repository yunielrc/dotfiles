#!/usr/bin/env bash

. "${LIBS_DIR}/bats-support/load.bash"
. "${LIBS_DIR}/bats-assert/load.bash"

test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export DEBUG=true
export PATH="${PATH}:~/.local/bin"

cd "$BATS_TEST_DIRNAME" || exit
