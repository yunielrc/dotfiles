#!/usr/bin/env bash

set -euE

export DEBIAN_FRONTEND=noninteractive

# Idempotent
type -P docker &> /dev/null && {
  echo 'docker currently installed'
  exit 0
}

# Dependencies
sudo apt update -y
sudo apt install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

# Add Repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) \
  stable"

# Install
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io

# install docker compose
readonly latest="$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -P 'tag_name' | head -n 1 | sed 's/"//g' | grep -Po '\d+\.\d+\.\d+')"
sudo curl -L "https://github.com/docker/compose/releases/download/${latest}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl -L "https://raw.githubusercontent.com/docker/compose/${latest}/contrib/completion/bash/docker-compose" -o /etc/bash_completion.d/docker-compose

# Configure

[[ "$USER" != root ]] && sudo usermod -aG docker "$USER"
sudo docker run -d --restart unless-stopped --name watchtower -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
