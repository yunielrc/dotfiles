# Load
# if [[ -d .git ]] || git rev-parse --git-dir > /dev/null 2>&1; then
FORGIT_PLUGIN_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${FORGIT_PLUGIN_PATH}/forgit/forgit.plugin.sh"
unset FORGIT_PLUGIN_PATH
# fi
