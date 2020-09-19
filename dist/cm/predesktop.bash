apt-u
# bashc & home-scripts can be installed with .env.template default values
dotf-i bashc
# add /etc/hosts
dotf-i root-config
# config network, add vpn
dotf-i network-config

if [[ "${INSTALL_WITH_VPN:-}" == true ]]; then
  # LOAD NETWORK CONFIG
  nmcli conn up "$NETWORK_CONFIG_CONN_VPN"
fi

dotf-i home-scripts # install gpg-backup, rsync-backup

if [[ "${INSTALL_APT_CACHER:-}" == true ]]; then
  dotf-i apt-cacher-ng
fi
