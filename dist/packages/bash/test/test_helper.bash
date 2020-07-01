# shellcheck disable=SC1090
. "${DIST_PATH}/lib/test_helper_base.bash"


. "$(realpath '../content/.bashc/init')"
# shellcheck disable=SC2155
export BASHC_PATH="$(realpath ./fixtures/.bashc)"
# shellcheck disable=SC2155
export PKG_PATH="$(realpath ../..)"
