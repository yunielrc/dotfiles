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
  local -r plugin_file_path="${DIST_PATH}/packages/${plugin}/content/${plugin}.plugin.bash"
  local -r plugin_file_dest_path="${BASH_PLUGINS_DIR}/${plugin}.plugin.bash"

  inf "Setting bash plugin: ${plugin}"

  if [[ ! -f "$plugin_file_path" ]]; then
    err "Setting bash plugin: ${plugin}, plugin doesn't exist: $plugin_file_path"
    return 10
  fi

  if [[ ! -d "$BASH_PLUGINS_DIR" ]]; then
    err "Setting bash plugin: ${plugin}, plugins dir doesn't exist: $BASH_PLUGINS_DIR"
    return 11
  fi

  ln --symbolic --verbose "$plugin_file_path" "$plugin_file_dest_path"
  echo "BASHC_PLUGINS=+($plugin)" >> "$BASH_GEN_SETTINGS_FILE"
  inf "DONE. Setting bash plugin: ${plugin}" "$GREEN"

  return 0
}


install_package() {
  local -r pkg="$1"

  local -r pkg_dir="${DIST_PATH}/packages/${pkg}"
  local -r setup_file_path="${pkg_dir}/setup"
  local -r plugin_file_path="${pkg_dir}/content/${pkg}.plugin.bash"

  inf "Setting package: ${pkg}"

  if [[ ! -f "$setup_file_path" ]]; then
    err "Setting package: ${pkg}, package doesn't exist: $plugin_file_path"
    return 10
  fi

  local out=''
  out="$(bash "$setup_file_path" 2>&1)"
  local -r ecode=$?

  if [[ $ecode != 0 ]] ; then
    echoc "$out" "$RED"
    err "Setting package: ${pkg}"
    return $ecode
  else
    echoc "$out" "$GREEN"
  fi

  if [[ -f "$plugin_file_path" ]]; then
    install_plugin "$pkg"
  fi
  inf "DONE. Setting package: ${pkg}" "$GREEN"
  return 0
}

alias addp='install_package'
export -f err inf infn debug
export addp
