#!/usr/bin/env bash

set -euEo pipefail

set -o allexport
. "${WORKDIR}/.env"
set +o allexport

export DEBIAN_FRONTEND=noninteractive

# APT cache proxy
[[ -n "${APT_PROXY:-}" ]] && echo "${APT_PROXY:-}" > /etc/apt/apt.conf.d/00proxy

# System update
apt-get update -y
apt-get upgrade -y

# Install
apt-get install -y tzdata wget file sudo xz-utils uuid-runtime gnupg tzdata 9base unzip curl
ln -s --force /usr/share/zoneinfo/America/Havana /etc/localtime

# APT clean
apt-get autoremove -y
apt-get autoclean -y
rm -rf /var/lib/apt/lists/*

# User
echo "${USER_NAME} ALL=NOPASSWD:ALL" > /etc/sudoers.d/nopasswd

if ! getent passwd | grep --quiet "$USER_NAME" ; then
  useradd --create-home --shell /bin/bash "$USER_NAME"
  usermod -aG sudo "$USER_NAME"
fi
# shellcheck disable=SC2028
echo 'XKBMODEL="pc105"\nXKBLAYOUT="us"\nXKBVARIANT="alt-intl"\nBACKSPACE="guess"' > /etc/default/keyboard

readonly text="cd ${WORKDIR}"
readonly file="/home/${USER_NAME}/.bashrc"

if ! grep -q "$text" "$file"; then
  echo "$text" >> "$file"
  chown "${USER_NAME}:${USER_NAME}" "$file"
fi
