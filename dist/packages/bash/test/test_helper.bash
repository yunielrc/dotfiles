# shellcheck disable=SC1090
. "${LIBS}/bats-support/load.bash"
. "${LIBS}/bats-assert/load.bash"


cd "$BATS_TEST_DIRNAME" || exit

export DEBUG=true
readonly INIT="$(realpath '../content/.bashc/init')"
. "$INIT"
export BASHC_PATH="$(realpath ./fixtures/.bashc)"
