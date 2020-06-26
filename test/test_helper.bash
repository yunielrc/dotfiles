# shellcheck disable=SC1090
. "${LIBS}/bats-support/load.bash"
. "${LIBS}/bats-assert/load.bash"

TEST_NAME="${BATS_TEST_FILENAME##*/}"
readonly TEST_NAME="${TEST_NAME%.bats}"
readonly TMP_DIR="${BATS_TMPDIR}/$(uuidgen)"
# shellcheck disable=SC2034
readonly FIXTURE_ROOT="${BATS_TEST_DIRNAME}/fixtures/"


becho() {
  echo -e "# $1" >&3
}

teardown() {
  if [[ -d "$TMP_DIR" ]]; then
    rm -rf "$TMP_DIR"
  fi
}

cd "$BATS_TEST_DIRNAME" || exit

readonly HELLO="$(realpath '../dist/hello')"
