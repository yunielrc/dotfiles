apt-u
# bashc & home-scripts can be installed with .env.template default values
dotf-i bashc
dotf-i root-config # /etc/hosts
dotf-i nm-config

if [[ "${INSTALL_WITH_VPN:-}" == true ]]; then
  # LOAD NETWORK CONFIG
  sudo systemctl restart network-manager
  nmcli conn up "$NETCONN_TOGGLE_VPN_CONN"
fi

dotf-i home-scripts # install gpg-backup, rsync-backup

if [[ "${INSTALL_APT_CACHER:-}" == true ]]; then
  dotf-i apt-cacher-ng
fi