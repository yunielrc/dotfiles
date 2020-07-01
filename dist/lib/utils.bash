#!/usr/bin/env bash

echoc() {
  local -r color="${2-$BLUE}"

  if [[ "${ENV,,}" != 'production' ]]; then
    echo -e "$*"
  else
    echo -e "${color}$*${NOCOLOR}" >&2
  fi
}

err() {
  local -r color="${2-$RED}"

  if [[ "${ENV,,}" != 'production' ]]; then
    echo -e "ERROR> $*" >&2
  else
    echo -e "${color}ERROR> $*${NOCOLOR}" >&2
  fi
}

inf() {
  local -r color="${2-$LIGHTBLUE}"

  if [[ "${ENV,,}" != 'production' ]]; then
    echo -e "INFO> $*"
  else
    echo -e "${color}INFO> $*${NOCOLOR}"
  fi
}

infn() {
  local -r color="${2-$LIGHTBLUE}"

  if [[ "${ENV,,}" != 'production' ]]; then
    echo -e -n "INFO> $*"
  else
    echo -e -n "${color}INFO> $*${NOCOLOR}"
  fi
}

debug() {
  if [[ "${ENV,,}" != 'production' ]]; then
    echo "DEBUG> $*"
  fi
}

install_plugin() {
  local -r plugin="$1"

  local -r pkg="$plugin"
  local -r plugin_file_path="${PKG_PATH}/${pkg}/content/${plugin}.plugin.bash"
  local -r plugin_file_dest_path="${BASH_PLUGINS_DIR}/${plugin}.plugin.bash"

  local -r msg="Installing bash plugin"

  inf "${msg}: ${plugin}"

  if [[ ! -f "$plugin_file_path" ]]; then
    err "${msg}: ${plugin}, plugin doesn't exist in: $plugin_file_path"
    return 10
  fi

  if [[ ! -d "$BASH_PLUGINS_DIR" ]]; then
    err "${msg}: ${plugin}, plugins dir doesn't exist: $BASH_PLUGINS_DIR"
    return 11
  fi

  ln --symbolic --verbose "$plugin_file_path" "$plugin_file_dest_path" || {
    err "${msg}: ${plugin}, creating link"
    return 12
  }
  echo "BASHC_PLUGINS=+($plugin)" >> "$BASH_GEN_SETTINGS_FILE" || {
    err "${msg}: ${plugin}, adding plugin to settings"
    return 13
  }

  inf "DONE. ${msg}: ${plugin}" "$GREEN"
  return 0
}

install_package() {
  local -r pkg="$1"

  local -r pkg_dir="${PKG_PATH}/${pkg}"
  local -r setup_file_path="${pkg_dir}/setup"
  local -r plugin_file_path="${pkg_dir}/content/${pkg}.plugin.bash"
  local -r msg='Installing package'

  inf "${msg}: ${pkg}"

  if [[ ! -f "$setup_file_path" ]]; then
    err "${msg}: ${pkg}, package doesn't exist: $plugin_file_path"
    return 10
  fi

  bash "$setup_file_path" || {
    err "${msg}: ${pkg}, executing package setup"
    return 11
  }

  if [[ -f "$plugin_file_path" ]]; then
    install_plugin "$pkg" || {
      err "${msg}: ${pkg}, installing bash plugin"
      return 12
    }
  fi

  inf "DONE. ${msg}: ${pkg}" "$GREEN"
  return 0
}

alias addp='install_package'
export -f err inf infn debug
export addp
