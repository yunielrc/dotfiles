#!/usr/bin/env bash

set -euEo pipefail

export DEBIAN_FRONTEND=noninteractive
readonly USER_NAME=ubuntu

set -o allexport
. ~/.dotfiles/.env
set +o allexport

# APT cache proxy
[[ -n "$APT_PROXY" ]] && echo "$APT_PROXY" > /etc/apt/apt.conf.d/00proxy

# System update
apt update -y
apt upgrade -y

# Timezone
apt install -y tzdata
ln -s --force /usr/share/zoneinfo/America/Havana /etc/localtime
timedatectl

# User
if ! getent passwd | grep --quiet "$USER_NAME" ; then
  useradd --create-home --shell /bin/bash "$USER_NAME"
  usermod -aG sudo "$USER_NAME"
fi
