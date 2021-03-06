#!/usr/bin/env bash

set -euEo pipefail

export DEBIAN_FRONTEND=noninteractive

if [[ -z "${BASE_PATH:-}" ]]; then
  readonly BASE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi
if [[ -z "${WORK_DIR:-}" ]]; then
  readonly WORK_DIR="$BASE_PATH"
fi

set -o allexport
. "${WORK_DIR}/.env"
set +o allexport

export PKGS_PATH="${WORK_DIR}/packages"
readonly PKGS_PATH
# export PKGS_PATH="${WORK_DIR}/packages"

. "${BASE_PATH}/lib/bash-libs/dist/bl.bash"

# Functions

## DOTFILES FUNCTIONS

#
# Install dotfiles theme
#
# Arguments:
#   theme       theme name
#
# Returns:
#   0 on success, non-zero on error.
#
__install_theme() {
  local -r theme="$1"

  local -r pkg="$theme"
  local theme_file_path="${PKGS_PATH}/${pkg}/${theme}.theme.bash"
  [[ ! -f "$theme_file_path" ]] && theme_file_path="${PKGS_PATH}/${pkg}/content/${theme}.theme.bash"
  local -r theme_file_dest_path="${DOTF_BASH_THEMES_DIR}/${theme}.theme.bash"

  local -r msg="Installing bash theme"

  inf "${msg}: ${theme}"

  if [[ ! -f "$theme_file_path" ]]; then
    err "${msg}: ${theme}, theme doesn't exist in: $theme_file_path"
    return 10
  fi

  if [[ ! -d "$DOTF_BASH_THEMES_DIR" ]]; then
    err "${msg}: ${theme}, themes dir doesn't exist: $DOTF_BASH_THEMES_DIR"
    return 11
  fi

  ln --symbolic --verbose --force "$theme_file_path" "$theme_file_dest_path" || {
    err "${msg}: ${theme}, creating link"
    return 12
  }

  inf "DONE. ${msg}: ${theme}" "$GREEN"
  return 0
}
export -f __install_theme

#
# Install dotfiles plugin
#
# Arguments:
#   plugin       plugin name
#
# Returns:
#   0 on success, non-zero on error.
#
__install_plugin() {
  local -r plugin="$1"

  local -r pkg="$plugin"
  local plugin_file_path="${PKGS_PATH}/${pkg}/${plugin}.plugin.bash"
  [[ ! -f "$plugin_file_path" ]] && plugin_file_path="${PKGS_PATH}/${pkg}/content/${plugin}.plugin.bash"
  local -r plugin_file_dest_path="${DOTF_BASH_PLUGINS_DIR}/${plugin}.plugin.bash"

  local -r msg="Installing bash plugin"

  inf "${msg}: ${plugin}"

  if [[ ! -f "$plugin_file_path" ]]; then
    err "${msg}: ${plugin}, plugin doesn't exist in: $plugin_file_path"
    return 10
  fi

  if [[ ! -d "$DOTF_BASH_PLUGINS_DIR" ]]; then
    err "${msg}: ${plugin}, plugins dir doesn't exist: $DOTF_BASH_PLUGINS_DIR"
    return 11
  fi

  ln --symbolic --verbose --force "$plugin_file_path" "$plugin_file_dest_path" || {
    err "${msg}: ${plugin}, creating link"
    return 12
  }

  if [[ ! -f "$DOTF_BASH_GEN_SETTINGS_FILE" ]] || ! grep --silent "BASHC_PLUGINS+=($plugin)" "$DOTF_BASH_GEN_SETTINGS_FILE"; then
    echo "BASHC_PLUGINS+=($plugin)" >>"$DOTF_BASH_GEN_SETTINGS_FILE" || {
      err "${msg}: ${plugin}, adding plugin to settings"
      return 13
    }
  fi

  inf "DONE. ${msg}: ${plugin}" "$GREEN"
  return 0
}
export -f __install_plugin

#
# Install dotfiles package
#
# Arguments:
#   pkg       package name
#   force     force package installation, true or false
#
# Returns:
#   0 on success, non-zero on error.
#
__install_package() {
  local -r pkg="$1"
  local -r force="${2:-false}"

  local -r pkg_dir="${PKGS_PATH}/${pkg}"

  local -r msg='Installing package'

  if [[ ! -d "$pkg_dir" ]]; then
    err "${msg}: ${pkg}, package doesn't exist: ${pkg_dir}"
    return 10
  fi

  # Guarantees Idempotency
  [[ "$force" == false ]] && type -P "$pkg" &>/dev/null && {
    inf "${pkg} currently installed"
    return 0
  }

  # Execute pkg setup
  local -r setup_file_path="${pkg_dir}/setup"

  if [[ -f "$setup_file_path" ]]; then
    env PKG_CONTENT="${PKGS_PATH}/${pkg}/content" PKG_PATH="${PKGS_PATH}/${pkg}" bash "$setup_file_path" || {

      if [[ $? -eq 55 ]]; then
        inf "${pkg} currently installed"
        return 0
      fi
      err "${msg}: ${pkg}, executing package setup"
      return 11
    }
  fi
  # :

  # Setup docker-compose.yml
  local -r pkg_dcompose_file="${pkg_dir}/docker-compose.yml"

  if [[ -f "$pkg_dcompose_file" ]]; then
    type -P docker >/dev/null || dotf-i docker
    (
      cd "${pkg_dir}"
      sudo docker-compose up -d || {
        err "${msg}: ${pkg}, on docker-compose up"
        return 13
      }
    )
  fi
  # :

  # Setup script_url
  local -r pkg_script_url="${pkg_dir}/script-url"

  if [[ -f "$pkg_script_url" ]]; then
    wget -qO - -i "$pkg_script_url" | bash || {
      err "${msg}: ${pkg}, installing package from script_url: ${pkg_script_url}"
      return 20
    }
  fi
  # :

  # Install bashc plugin
  local -r plugin_file_path="${pkg_dir}/${pkg}.plugin.bash"
  local -r plugin_file_path2="${pkg_dir}/content/${pkg}.plugin.bash"

  if [[ -f "$plugin_file_path" || -f "$plugin_file_path2" ]]; then
    __install_plugin "$pkg" || {
      err "${msg}: ${pkg}, installing bash plugin"
      return 12
    }
  fi
  # :

  # Install bashc theme
  local -r theme_file_path="${pkg_dir}/${pkg}.theme.bash"
  local -r theme_file_path2="${pkg_dir}/content/${pkg}.theme.bash"

  if [[ -f "$theme_file_path" || -f "$theme_file_path2" ]]; then
    __install_theme "$pkg" || {
      err "${msg}: ${pkg}, installing bash theme"
      return 12
    }
  fi
  # :

  # Recursive concat files to home directory
  local -r pkg_homecat_path="${pkg_dir}/homecat"

  if [[ -d "$pkg_homecat_path" ]]; then
    bl::recursive_concat "$pkg_homecat_path" ~/ || {
      err "${msg}: ${pkg}, recursive concat files to home directory"
      return 14
    }
  fi
  # :

  # Recursive concat files to root directory
  local -r pkg_rootcat_path="${pkg_dir}/rootcat"

  if [[ -d "$pkg_rootcat_path" ]]; then
    bl::recursive_concat "$pkg_rootcat_path" / || {
      err "${msg}: ${pkg}, recursive concat files to root directory"
      return 14
    }
  fi
  # :

  # Recursive copy files with env substitution to home directory
  local -r pkg_homecps_path="${pkg_dir}/homecps"

  if [[ -d "$pkg_homecps_path" ]]; then
    bl::recursive_copy_envsub "$pkg_homecps_path" ~/ || {
      err "${msg}: ${pkg}, recursive copy files with env substitution to home directory"
      return 15
    }
  fi
  # :

  # Recursive copy files with env substitution to root directory
  local -r pkg_rootcps_path="${pkg_dir}/rootcps"

  if [[ -d "$pkg_rootcps_path" ]]; then
    bl::recursive_copy_envsub "$pkg_rootcps_path" / || {
      err "${msg}: ${pkg}, recursive copy files with env substitution to root directory"
      return 15
    }
  fi
  # :

  shopt -s dotglob

  # Make recursive slinks files to home directory
  local -r pkg_home_path="${pkg_dir}/home"

  if [[ -d "$pkg_home_path" ]]; then
    cp --symbolic-link --recursive --force --verbose --backup "$pkg_home_path"/* ~/ || {
      err "${msg}: ${pkg}, installing recursive slinks to home directory"
      return 16
    }
  fi
  # :

  # Make recursive slinks files to root directory
  local -r pkg_root_path="${pkg_dir}/root"

  if [[ -d "$pkg_root_path" ]]; then
    sudo cp --symbolic-link --recursive --force --verbose --backup "$pkg_root_path"/* / || {
      err "${msg}: ${pkg}, installing recursive slinks to root directory"
      return 16
    }
  fi
  # :

  # Recursive copy files to root directory
  local -r pkg_rootcp_path="${pkg_dir}/rootcp"

  if [[ -d "$pkg_rootcp_path" ]]; then
    sudo cp --recursive --force --verbose --backup "$pkg_rootcp_path"/* / || {
      err "${msg}: ${pkg}, recursive copy files to root directory"
      return 17
    }
  fi
  # :

  # Recursive copy files to home directory
  local -r pkg_homecp_path="${pkg_dir}/homecp"

  if [[ -d "$pkg_homecp_path" ]]; then
    cp --recursive --force --verbose --backup "$pkg_homecp_path"/* ~/ || {
      err "${msg}: ${pkg}, recursive copy files to home directory"
      return 17
    }
  fi
  # :

  # Recursive link top files to home directory
  local -r pkg_homeln_path="${pkg_dir}/homeln"

  if [[ -d "$pkg_homeln_path" ]]; then
    ln --symbolic --force --verbose --backup "$pkg_homeln_path"/* ~/ || {
      err "${msg}: ${pkg}, recursive link top files to home directory"
      return 18
    }
  fi
  # :

  # Recursive link top files to root directory
  local -r pkg_rootln_path="${pkg_dir}/rootln"

  if [[ -d "$pkg_rootln_path" ]]; then
    sudo ln --symbolic --force --verbose --backup "$pkg_rootln_path"/* / || {
      err "${msg}: ${pkg}, recursive link top files to root directory"
      return 18
    }
  fi
  # :
  shopt -u dotglob

  # Import dconf.ini
  local -r pkg_dconf_file="${pkg_dir}/dconf.ini"

  if [[ -f "$pkg_dconf_file" ]]; then
    envsubst <"$pkg_dconf_file" | dconf load / || {
      err "${msg}: ${pkg}, importing dconf.ini"
      return 19
    }
  fi
  # :

  # Execute pkg postsetup
  local -r postsetup_file_path="${pkg_dir}/postsetup"

  if [[ -f "$postsetup_file_path" ]]; then
    env PKG_CONTENT="${PKGS_PATH}/${pkg}/content" PKG_PATH="${PKGS_PATH}/${pkg}" bash "$postsetup_file_path" || {
      err "${msg}: ${pkg}, executing package postsetup"
      return 25
    }
  fi
  # :
  return 0
}
export -f __install_package

#
# Install dotfiles package
# show installation messages with colors & log errors
#
# Arguments:
#   pkg       package name
#   force     force package installation, true or false
#
# Returns:
#   0 on success, non-zero on error.
#
dotf-i() {
  local force=false

  local positional=()
  while [[ $# -gt 0 ]]; do
    case "$1" in
    -f | --force)
      force=true
      shift
      ;;
    *)
      positional+=("$1")
      shift
      ;;
    esac
  done

  set -- "${positional[@]}" # restore local positional params
  local -r pkg="$1"
  # local -r color="\e[3$(( "$RANDOM" * 6 / 32767 + 1 ))m"

  __dotf_i_out() {
    local -i ecode=0

    if [[ -z "${ENV:-}" || "${ENV,,}" != 'production' ]]; then
      local -r msg="Installing package ${pkg}"
      echo -e "\n> ${msg}"
      if __install_package "$pkg" $force; then
        echo -e "> DONE. ${msg}"
      else
        ecode=$?
        echo -e "> FAIL. ${msg}"
      fi
    else
      local -r msg="${WHITE} Installing package${NOCOLOR} ${YELLOW}${pkg}${NOCOLOR}"
      echo -e "\n${WHITE}>${NOCOLOR}${msg}"
      if __install_package "$pkg" $force; then
        echo -e "${WHITE}>${NOCOLOR}${LIGHTGREEN} DONE.${msg}${NOCOLOR}"
      else
        ecode=$?
        echo -e "${WHITE}>${NOCOLOR}${LIGHTRED} FAIL.${msg}${NOCOLOR}"
      fi
    fi
    return "$ecode"
  }

  local -i ecode
  local -r out_file="$(mktemp)"
  __dotf_i_out 2>&1 | tee "$out_file"
  ecode="${PIPESTATUS[0]}"

  if [[ $DOTF_LOG_ERRORS == true && "$ecode" -ne 0 ]]; then
    __log_error "$out_file"
  fi
  return "$ecode"
}
export -f dotf-i

__log_error() {
  local -r errmsg_file="$1"
  [[ -f "$errmsg_file" ]]

  cat <<EOF >>~/.dotfiles.err.log

--------------------------------------------------------------
$(date +%Y%m%d-%H%M%S)
--------------------------------------------------------------
$(cat "$errmsg_file")
EOF
  rm -f "$errmsg_file"
}
export -f __log_error

## :DOTFILES FUNCTIONS

apt-u() { sudo apt-get update -y; }
export -f apt-u

apt-ug() { sudo apt-get update -y && sudo apt-get upgrade -y; }
export -f apt-ug

apt-i() {
  local -i ecode
  local -r out_file="$(mktemp)"
  sudo apt-get install -y "$@" 2>&1 | tee "$out_file"
  ecode="${PIPESTATUS[0]}"

  if [[ $DOTF_LOG_ERRORS == true && "$ecode" -ne 0 ]]; then
    __log_error "$out_file"
  fi
}
export -f apt-i

brew-i() {
  local -i ecode
  local -r out_file="$(mktemp)"

  type -P brew >/dev/null || {
    dotf-i brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  }

  brew install "$@" 2>&1 | tee "$out_file"
  ecode="${PIPESTATUS[0]}"

  if [[ $DOTF_LOG_ERRORS == true && "$ecode" -ne 0 ]]; then
    __log_error "$out_file"
  fi
}
export -f brew-i

add_apt_key() {
  local -r apt_key="$1"
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys "$apt_key"
}
export -f add_apt_key

# Execute command as a login shell with default SHELL
shl() {
  bash -l -c "$*"
}
export -f shl
