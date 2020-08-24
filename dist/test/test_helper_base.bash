#!/usr/bin/env bash

. "${LIBS_DIR}/bats-support/load.bash"
. "${LIBS_DIR}/bats-assert/load.bash"

test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export ENV=testing
readonly ENV
export DEBUG=true
export PATH="${PATH}:${HOME_BIN}"
# export PATH="${PATH}:../home/.usr/bin"
# shellcheck disable=SC2034
REL_BIN=../home/.usr/bin

[[ ! -d ~/.bashc ]] && {
  mkdir -p ~/.bashc/{gen,plugins/local}
}

cd "$BATS_TEST_DIRNAME" || exit
